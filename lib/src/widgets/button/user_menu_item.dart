class UserMenuItem {
  const UserMenuItem({
    required this.label,
    required this.iconPath,
    this.onTap,
  });

  final String label;
  final String iconPath;
  final void Function()? onTap;
}
