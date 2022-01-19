class NotificationState {
  final bool permissionRequested;
  final bool isNotificationAllowed;
  final bool navigate;

  NotificationState(
      {this.permissionRequested = false,
      this.isNotificationAllowed = true,
      this.navigate = false});

  NotificationState copyWith(
          {bool? permissionRequested,
          bool? isNotificationAllowed,
          bool? navigate}) =>
      NotificationState(
          permissionRequested: permissionRequested ?? this.permissionRequested,
          isNotificationAllowed:
              isNotificationAllowed ?? this.isNotificationAllowed,
          navigate: navigate ?? this.navigate);
}
