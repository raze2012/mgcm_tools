import 'package:mgcm_tools/model/ModelEnums.dart';

extension _StringUtils on String {
  bool equalsIgnoreCase(String other) {
    return this.toLowerCase() == other.toLowerCase();
  }
}

class CSVValidator {
  static String baseSheetsURL = "https://docs.google.com/spreadsheets/d/1HkroakfeauzCiTS8rNJxwVCD-a9rb1h_hhOh8Gx20OE/";
  static String csvQuery = "gviz/tq?tqx=out:csv&sheet=";
  static String skillSheet = "SkillsDB";
  static String dressSheet = "DressDB";
  static String testSheet = "meep";

  static String dressURL = baseSheetsURL + csvQuery + dressSheet;
  static String skillURL = baseSheetsURL + csvQuery + skillSheet;
  static String testURL = baseSheetsURL + csvQuery + testSheet;

  static bool validateSkillTable(List<List<dynamic>> table, List<String> errorMessage) {
    if (!validateSkillHeaders(table, errorMessage)) {
      return false;
    }

    for (int i = 1; i < table.length; i++) {
      if (!validateSkillRow(table[i], errorMessage, i)) {
        return false;
      }
    }

    if (!validateSkillIDS(table, errorMessage)) {
      return false;
    }

    return true;
  }

  static bool validateDressTable(List<List<dynamic>> table, List<String> errorMessage) {
    if (!validateDressHeaders(table, errorMessage)) {
      return false;
    }

    for (int i = 1; i < table.length; i++) {
      if (!validateDressRow(table[i], errorMessage, i)) {
        return false;
      }
    }

    if (!validateDressIDs(table, errorMessage)) {
      return false;
    }

    return true;
  }

  static bool validateHeaders(List<String> expectedHeaders, List<dynamic> header, List<String> errorMessage) {
    if (header.length != expectedHeaders.length) {
      errorMessage.add("Incorrect number of columns, expected " +
          expectedHeaders.length.toString() +
          " but has " +
          header.length.toString() +
          " instead");
      return false;
    }

    for (int i = 0; i < header.length; i++) {
      String col = header[i];
      if (!col.equalsIgnoreCase(expectedHeaders[i])) {
        errorMessage.add(
            "Header error (col " + i.toString() + "): expected " + expectedHeaders[i] + " but got " + col + " instead");
        return false;
      }
    }

    return true;
  }

  static bool validateSkillHeaders(List<List<dynamic>> table, List<String> errorMessage) {
    var expectedHeaders = [
      "skillKind",
      "skillID",
      "skillName",
      "owner",
      "attribute",
      "effect",
      "targetType",
      "isAttack",
      "recastMax",
      "recastMin",
      "maxLevel",
      "skillLvUp2",
      "skillLvUp3",
      "skillLvUp4",
      "skillLvUp5",
      "skillLvUp6",
      "skillLvUp7",
      "skillLvUp8",
      "buffs",
      "debuffs",
      "specialEffects",
      "numHits",
      "skillMod",
      "hpMod",
      "defMod",
      "spdMod",
      "enemyHPMod",
      "enemySPDMod"
    ];

    List<dynamic> header = table[0];

    return validateHeaders(expectedHeaders, header, errorMessage);
  }

  static bool validateDressHeaders(List<List<dynamic>> table, List<String> errorMessage) {
    var expectedHeaders = [
      "DressID",
      "DressAssetID",
      "Dress Name",
      "Rarity",
      "Type",
      "Attribute",
      "Character",
      "HP1",
      "ATK1",
      "DEF1",
      "AGI1",
      "HP60",
      "ATK60",
      "DEF60",
      "AGI60",
      "HP80",
      "ATK80",
      "DEF80",
      "AGI80",
      "FCS",
      "RES",
      "Skill1Kind",
      "Skill1ID",
      "Skill2Kind",
      "Skill2ID",
      "Skill3Kind",
      "Skill3ID",
      "Skill4Kind",
      "Skill4ID"
    ];

    List<dynamic> header = table[0];

    return validateHeaders(expectedHeaders, header, errorMessage);
  }

  static bool validateDressRow(List<dynamic> dressRow, List<String> errorMessage, int index) {
    String baseMessage = "Error on row " + (index + 1).toString() + ": ";

    var dressID = int.tryParse(dressRow[0].toString());
    if (dressID == null) {
      errorMessage.add(baseMessage + "DressID must be an integer");
      return false;
    }

    if (dressID < 1) {
      errorMessage.add(baseMessage + "DressID must be a positive (non-zero) integer");
      return false;
    }

    var assetID = int.tryParse(dressRow[1].toString());

    if (assetID == null) {
      errorMessage.add(baseMessage + "AssetID must be an integer");
      return false;
    }

    /*asset nomenclature: [rarity number][character number][dress number]
        //where rarity means 1,2,3,4 for N,R,SR,UR. character number is 01-12, and dress number is a 3 digit number
        //you can find the number either by datamining and finding the asset name under ui\card\thumbnail
        //or by going to a JP site and using "inspect element" on dress thumbnails*/
    if (assetID < 100000 && assetID > 412999 && assetID % 10000 < 1000) {
      errorMessage.add(baseMessage + "assetID out of range");
      return false;
    }

    if (dressRow[2].toString().isEmpty) {
      errorMessage.add(baseMessage + "dress name should not be empty");
      return false;
    }

    if (!["N", "R", "SR", "UR"].contains(dressRow[3].toString().toUpperCase())) {
      errorMessage.add(baseMessage + "invalid rarity. should be N, R, SR, or UR");
      return false;
    }

    if (!["assist", "attack", "guard", "tank"].contains(dressRow[4].toString().toLowerCase())) {
      errorMessage.add(baseMessage + "invalid type. Should be assist, attack, guard, ot tank");
      return false;
    }

    var attr = dressRow[5];
    Attribute.values.firstWhere((element) {
      return element.toName().equalsIgnoreCase(attr);
    }, orElse: () {
      errorMessage.add(baseMessage + "invalid element. provide an element or use 'None' if not applicable");
      return Attribute.None;
    });

    var character = dressRow[6];
    bool stillValid = true;
    Character.values.firstWhere((e) {
      return getCharacterFullName(character) == e;
    }, orElse: () {
      stillValid = false;
      errorMessage.add(baseMessage + "invalid character name. make sure spelling is correct (only first name matters)");
      return Character.Iroha;
    });

    if (!stillValid) return false;

    var columnIter = 7;
    ["HP1", "ATK1", "DEF1", "AGI1", "HP60", "ATK60", "DEF60", "AGI60", "HP80", "ATK80", "DEF80", "AGI80", "FCS", "RES"]
        .forEach((element) {
      if (int.tryParse(dressRow[columnIter].toString()) == null) {
        errorMessage.add(baseMessage + element + " must be an integer");
        return false;
      }
      columnIter++;
    });

    assert(columnIter == 21);

    int s1K = int.tryParse(dressRow[21].toString());
    if (s1K == null) {
      errorMessage.add(baseMessage + "skill1Kind must be an integer");
      return false;
    }

    if (s1K < 1 || s1K > 3) {
      errorMessage.add(baseMessage + "Skill1Kind must be 1 (command), 2 (passive), or 3 (arousal)");
      return false;
    }

    int s1ID = int.tryParse(dressRow[22].toString());
    if (s1ID == null) {
      errorMessage.add(baseMessage + "skill1ID must be an integer");
      return false;
    }

    if (s1ID < 1) {
      errorMessage.add(baseMessage + "Skill1ID must be a positive (non-zero) integer");
      return false;
    }

    columnIter = 23;

    ["Skill2Kind", "Skill3Kind", "Skill4Kind"].forEach((element) {
      if (dressRow[columnIter].toString().isNotEmpty) {
        int sK = int.tryParse(dressRow[columnIter].toString());
        if (sK == null) {
          errorMessage.add(baseMessage + element + " must be an integer");
          return false;
        }

        if (sK < 1 || sK > 3) {
          errorMessage.add(baseMessage + element + " must be 1 (command), 2 (passive), or 3 (arousal)");
          return false;
        }
      }

      columnIter += 2;
    });

    columnIter = 24;

    ["Skill2ID", "Skill3ID", "Skill4ID"].forEach((element) {
      if (dressRow[columnIter].toString().isNotEmpty) {
        int sID = int.tryParse(dressRow[columnIter].toString());
        if (sID == null) {
          errorMessage.add(baseMessage + element + " must be an integer");
          return false;
        }

        if (sID < 1) {
          errorMessage.add(baseMessage + element + " must be a positive (non-zero) integer");
          return false;
        }
      }
      columnIter += 2;
    });

    return true;
  }

  static bool validateSkillRow(List<dynamic> skillRow, List<String> errorMessage, int index) {
    String baseMessage = "Error on row " + (index + 1).toString() + ": ";

    int skillKind = int.tryParse(skillRow[0].toString());

    if (skillKind == null) {
      errorMessage.add(baseMessage + "SkillKind must be an integer");
      return false;
    }

    if (skillKind < 1 || skillKind > 3) {
      errorMessage.add(baseMessage + "SkillKind must be 1 (command), 2 (passive), or 3 (arousal)");
      return false;
    }

    if (int.tryParse(skillRow[1].toString()) == null) {
      errorMessage.add(baseMessage + "SkillID must be an integer");
      return false;
    }

    String name = skillRow[2];
    if (name.isEmpty || name == null) {
      errorMessage.add(baseMessage + "Must provide a non-empty name");
      return false;
    }

    String owner = skillRow[3];
    if (owner.isEmpty || owner == null) {
      errorMessage.add(baseMessage + "Must provide a non-empy owner for skill");
      return false;
    }

    String attr = skillRow[4];

    bool stillValid = true;
    Attribute.values.firstWhere((element) {
      return element.toName().equalsIgnoreCase(attr);
    }, orElse: () {
      stillValid = false;
      errorMessage.add(baseMessage + "invalid element. provide an element or use 'None' if not applicable");
      return Attribute.None;
    });

    if (!stillValid) return false;

    String effect = skillRow[5];
    if (effect.isEmpty || effect == null) {
      errorMessage.add(baseMessage + "Must provide a non-empy effect for skill");
      return false;
    }

    String targetType = skillRow[6];

    SkillTargetType.values.firstWhere((target) {
      var t = target.toString().substring(target.toString().indexOf('.') + 1);
      return t.equalsIgnoreCase(targetType);
    }, orElse: () {
      stillValid = false;
      errorMessage
          .add(baseMessage + "invalid targetType. type should be 'single','multiple','random','all', or 'self'");
      return SkillTargetType.Single;
    });

    if (!stillValid) return false;

    bool validAttack =
        skillRow[7].toString().equalsIgnoreCase("TRUE") || skillRow[7].toString().equalsIgnoreCase("FALSE");

    if (!validAttack) {
      errorMessage.add(baseMessage + " isAttack should be either TRUE or FALSE");
      return false;
    }

    if (int.tryParse(skillRow[8].toString()) == null) {
      errorMessage.add(baseMessage + "recastMax must be an integer");
      return false;
    }

    if (int.tryParse(skillRow[9].toString()) == null) {
      errorMessage.add(baseMessage + "recastMin must be an integer");
      return false;
    }

    int maxLevel = int.tryParse(skillRow[10].toString());
    if (maxLevel == null) {
      errorMessage.add(baseMessage + "maxLevel must be an integer");
      return false;
    }

    if (maxLevel < 1) {
      errorMessage.add(baseMessage + "maxLevel must be at least 1 (base level for unleveled skills is 1");
      return false;
    }

    int i = 2;
    [skillRow[11], skillRow[12], skillRow[13], skillRow[14], skillRow[15], skillRow[16], skillRow[17]]
        .forEach((element) {
      if (i <= maxLevel && element.toString().isEmpty) {
        errorMessage.add(baseMessage +
            "maxLevel is " +
            maxLevel.toString() +
            ", but skill level " +
            i.toString() +
            " has an empty effect");
        return false;
      }

      i++;
    });

    if (skillRow[18].toString().isNotEmpty) {
      List<String> buffs = skillRow[18].toString().split(',');
      buffs.forEach((element) {
        element = element.trim();

        bool isBuff = Buff.values.indexWhere((buff) {
              var buffString = buff.toString().substring(buff.toString().indexOf('.') + 1);
              buffString = buffString.replaceAll('_', ' ');
              return buffString.equalsIgnoreCase(element);
            }) >
            -1;

        if (!isBuff) {
          errorMessage.add(baseMessage +
              "buff " +
              element +
              " not recognized. make sure entry is comma separated and properly spelled");
          return false;
        }
      });
    }

    if (skillRow[19].toString().isNotEmpty) {
      List<String> debuffs = skillRow[19].toString().split(',');
      debuffs.forEach((element) {
        element = element.trim();

        bool isDebuff = Debuff.values.indexWhere((debuff) {
              var debuffString = debuff.toString().substring(debuff.toString().indexOf('.') + 1);
              debuffString = debuffString.replaceAll('_', ' ');
              return debuffString.equalsIgnoreCase(element);
            }) >
            -1;

        if (!isDebuff) {
          errorMessage.add(baseMessage +
              "debuff " +
              element +
              " not recognized. make sure entry is comma separated and properly spelled");
          return false;
        }
      });
    }

    int colIter = 21;
    ["numHits", "skillMod", "hpMod", "defMod", "spdMod", "enemyHPMod", "enemySpdMod"].forEach((element) {
      if (num.tryParse(skillRow[colIter].toString()) == null) {
        errorMessage.add(baseMessage + element + " must be an integer");
        return false;
      }
      colIter++;
    });

    int count = 0;
    [skillRow[23], skillRow[24], skillRow[25], skillRow[26], skillRow[27]].forEach((element) {
      num specialMod = num.parse(element.toString());

      if (specialMod != 0) {
        count++;
      }
    });

    if (count > 1) {
      errorMessage.add(baseMessage +
          "skill cannot have multiple special mods. make sure one of the mods " +
          "is non-zero (a negative number indicates an existing, but unknown mod) and everything else is zero");
      return false;
    }

    return true;
  }

  static bool validateDressIDs(List<List<dynamic>> dressTable, List<String> errorMessage) {
    Set<int> ids = new Set();
    for (int i = 1; i < dressTable.length; i++) {
      var row = dressTable[i];

      int id = int.parse(row[0].toString());

      if (ids.contains(id)) {
        errorMessage.add(" found duplicate IDs of " + id.toString() + ". Make sure ID's are unique");
        return false;
      }
      ids.add(id);
    }

    return true;
  }

  static bool validateSkillIDS(List<List<dynamic>> skillTable, List<String> errorMessage) {
    Set<int> skill1Set = new Set();
    Set<int> skill2Set = new Set();
    Set<int> skill3Set = new Set();

    var sets = [skill1Set, skill2Set, skill3Set];

    for (int i = 1; i < skillTable.length; i++) {
      var row = skillTable[i];

      int skillKind = int.parse(row[0].toString());
      int skillID = int.parse(row[1].toString());

      if (sets[skillKind - 1].contains(skillID)) {
        errorMessage.add("multiple skills of kind " +
            skillKind.toString() +
            " and ID " +
            skillID.toString() +
            " found. Each skill kind can only have one id for a skill");
        return false;
      }
    }

    return true;
  }
}
