// product_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:tezda/core/data/models/request/createProduct.dart';
import 'package:tezda/core/data/models/response/createProductResponse.dart';
import '../../../core/data/models/response/defaultResponse.dart';
import '../../../core/data/models/response/updateProduct.dart';
import '../../../core/providers/productProvider/productProvider.dart';
import '../../../core/util/AppUtill.dart';
import '../../../core/util/color.dart';
class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context, ) {
    final productList = ref.watch(productProvider);

    return OverlayLoaderWithAppIcon(
      isLoading:isLoading,
      overlayBackgroundColor: AppColor.black40,
      circularProgressColor: AppColor.primary100,
      appIconSize: 20.h,
      appIcon: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: AppColor.black0,
        appBar: AppBar(title: Text('Products')),
        body: productList.isEmpty
            ? Center(child: Text('No products available'))
            : ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final product = productList[index];
            return ListTile(
              title: Text(product.title),
              subtitle: Text('Price: \$${product.price}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showProductDialog(context, ref,
                        productId: product.id),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await ref
                          .read(productProvider.notifier)
                          .deleteProduct(product.id);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showProductDialog(context, ref),
        ),
      ),
    );
  }

  void _showProductDialog(BuildContext context, WidgetRef ref,
      {int? productId}) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(productId == null ? 'Create Product' : 'Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                CreateProductRequest productData = CreateProductRequest(
                    title: nameController.text,
                    price: priceController.text,
                    description: "This is creative",
                    categoryId: 1,
                    images: [
                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fm.facebook.com%2FTezda-Immobilier-Services-102665449035677%2Fphotos%2Fpcb.138732028762352%2F138731795429042%2F&psig=AOvVaw0VGjxnmDhDOs1GcdPzbvpn&ust=1731493584703000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIC7s7LK1okDFQAAAAAdAAAAABAR"
                    ]);

                if (productId == null) {
                  final response= await ref.read(productProvider.notifier).createProduct(productData);
                  if(response is CreateProductResponse){
                    setState(() {
                      isLoading = false;
                    });
                    AppUtils.showSnack("Successful", context);
                  }else {
                    setState(() {
                      isLoading = false;
                    });
                    DefaultErrorFormat error = response as DefaultErrorFormat;
                    AppUtils.showSnack(error.message[0], context);
                  }
                } else {
                final response=  await ref
                      .read(productProvider.notifier)
                      .updateProduct(productId, productData);
                  if(response is UpdateProductResponse){
                    setState(() {
                      isLoading = false;
                    });
                    AppUtils.showSuccessSnack("Successful", context);
                  }else {
                    setState(() {
                      isLoading = false;
                    });
                    DefaultErrorFormat error = response as DefaultErrorFormat;
                    AppUtils.showSnack(error.message[0], context);
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text(productId == null ? 'Create' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
