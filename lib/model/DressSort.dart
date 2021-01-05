enum DressSort { DressNumber, Type, Attribute, Name, Rarity, HP, ATK, DEF, SPD, FCS, RES }

extension DressUtils on DressSort {
  String getLabel() {
    switch (this) {
      case DressSort.DressNumber:
        return "Dress no.";
      case DressSort.Type:
        return "Type.";
      case DressSort.Attribute:
        return "Attribute";
      case DressSort.Name:
        return "Name";
      case DressSort.Rarity:
        return "Rarity";
      case DressSort.HP:
        return "HP";
      case DressSort.ATK:
        return "ATK";
      case DressSort.DEF:
        return "DEF";
      case DressSort.SPD:
        return "SPD";
      case DressSort.FCS:
        return "FCS";
      case DressSort.RES:
        return "RES";
      default:
        return "?";
    }
  }
}

enum SkillSort { ID, Attribute, Name, SkillMod, NumHits, DPS }

extension SkillUtils on SkillSort {
  String getLabel() {
    switch (this) {
      case SkillSort.ID:
        return "ID";
      case SkillSort.Attribute:
        return "Attribute";
      case SkillSort.Name:
        return "Name";
      case SkillSort.SkillMod:
        return "Skill Mod";
      case SkillSort.NumHits:
        return "Hit Count";
      case SkillSort.DPS:
        return "Mod * Hits";
      default:
        return "?";
    }
  }
}
