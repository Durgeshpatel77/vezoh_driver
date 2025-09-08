// Model class for a service
class ServiceModel {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  bool isSelected;

  ServiceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isSelected = false,
  });

  ServiceModel copyWith({bool? isSelected}) {
    return ServiceModel(
      id: id,
      title: title,
      subtitle: subtitle,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
