class SidebarItem {
  const SidebarItem({
    required this.label,
    required this.outlineIconPath,
    required this.boldIconPath,
    this.onTap,
    this.onLongPress,
    this.onSecondaryTap,
  });

  final String label;
  final String outlineIconPath;
  final String boldIconPath;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function()? onSecondaryTap;
}
