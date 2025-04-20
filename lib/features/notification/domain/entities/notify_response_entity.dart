class NotifyResponseEntity {
  final bool isSuccess;

  const NotifyResponseEntity({this.isSuccess = false});

  factory NotifyResponseEntity.fromModel(NotifyResponseEntity model) {
    return NotifyResponseEntity(isSuccess: model.isSuccess);
  }
}
