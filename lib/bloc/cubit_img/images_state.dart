part of 'images_cubit.dart';
class ImagesState extends Equatable{
  final String? linkGambar;
  final bool isLoading;
  final double uploadProgress;
  final String errorMessage;
   final String? imgName;
   final List<String> imgNames;
    final List<String>? imgUrls;
  final String productId;

  const ImagesState( {
    this.linkGambar,
    this.isLoading = false,
    this.uploadProgress = 0,
    this.errorMessage= "",
    this.imgName,
    this.imgNames = const [],
    this.imgUrls = const [],
    this.productId = ""
  });

  @override
  List<Object?> get props => [
    linkGambar,isLoading,uploadProgress,errorMessage, imgName,imgNames,imgUrls
  ];
}