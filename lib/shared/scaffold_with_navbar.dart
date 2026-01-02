import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../responsive.dart';
import 'section_container.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: context.isMobile || context.isTablet
          ? AppBar(
              backgroundColor: AppTheme.secondaryBackground.withValues(
                alpha: 0.9,
              ),
              elevation: 0,
              title: Text(
                AppConstants.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 18),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu, color: AppTheme.primaryText),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ],
            )
          : null,
      endDrawer: context.isMobile || context.isTablet
          ? const _MobileDrawer()
          : null,
      body: Column(
        children: [
          if (context.isDesktop) const _DesktopNavbar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _DesktopNavbar extends StatelessWidget {
  const _DesktopNavbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.secondaryBackground.withValues(alpha: 0.9),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConstants.fullName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 20),
            ),
            Row(
              children: [
                _NavBarLink(label: 'Home', path: '/'),
                const SizedBox(width: 32),
                _NavBarLink(label: 'Projects', path: '/projects'),
                const SizedBox(width: 32),
                _NavBarLink(label: 'Articles', path: '/articles'),
                const SizedBox(width: 32),
                _NavBarLink(label: 'Contact', path: '/contact'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarLink extends StatelessWidget {
  const _NavBarLink({required this.label, required this.path});

  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    final isHovered = ValueNotifier(false);
    final GoRouterState state = GoRouterState.of(context);
    final isActive = state.uri.toString() == path; // Simple exact match for now

    return InkWell(
      onTap: () => context.go(path),
      hoverColor: Colors.transparent,
      onHover: (value) => isHovered.value = value,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, hovered, _) {
          return Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: hovered || isActive
                  ? AppTheme.primaryText
                  : AppTheme.secondaryText,
              fontWeight: hovered || isActive
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          );
        },
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.secondaryBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.elevatedBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppConstants.fullName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  AppConstants.role,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          _DrawerItem(icon: Icons.home, label: 'Home', path: '/'),
          _DrawerItem(icon: Icons.work, label: 'Projects', path: '/projects'),
          _DrawerItem(
            icon: Icons.article,
            label: 'Articles',
            path: '/articles',
          ),
          _DrawerItem(icon: Icons.mail, label: 'Contact', path: '/contact'),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.path,
  });

  final IconData icon;
  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryText),
      title: Text(label, style: const TextStyle(color: AppTheme.primaryText)),
      onTap: () {
        context.push(
          path,
        ); // Push instead of go to keep back stack on mobile potentially
        // But drawer usually implies replacement or reset.
        // For simple nav, go is cleaner:
        context.go(path);
      },
    );
  }
}
