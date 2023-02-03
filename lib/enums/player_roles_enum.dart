enum PlayerRoleEnum {
  none,
  delegate,
  goalkeeper,
  defender,
  midfield,
  attacker,
  polyvalent;
}

extension PlayerRoleEnumExtension on PlayerRoleEnum? {
  String format() {
    switch (this) {
      case PlayerRoleEnum.none:
        return "Pas de rôle";
      case PlayerRoleEnum.delegate:
        return "Délégué";
      case PlayerRoleEnum.goalkeeper:
        return "Gardien";
      case PlayerRoleEnum.defender:
        return "Défenseur";
      case PlayerRoleEnum.midfield:
        return "Milieu";
      case PlayerRoleEnum.attacker:
        return "Attaquant";
      case PlayerRoleEnum.polyvalent:
        return "Polyvalent";
      default:
        return "Inconnu";
    }
  }
}
