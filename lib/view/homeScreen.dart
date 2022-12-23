import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/data/response/status.dart';
import 'package:flutter_mvvm_architecture/utils/general_utils.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routesName.dart';
import 'package:flutter_mvvm_architecture/view_model/homeViewModel.dart';
import 'package:flutter_mvvm_architecture/view_model/userViewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.fetchMovieListApi();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              userPrefs.remove().then(
                  (value) => Navigator.pushNamed(context, RoutesName.login));
            },
            child: const Center(
              child: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, _) {
            switch (value.movieList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());

              case Status.ERROR:
                return Text(value.movieList.message.toString());

              case Status.COMPLETED:
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: value.movieList.data!.movies!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(value.movieList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value.movieList.data!.movies![index].year
                            .toString()),
                        leading: Image.network(
                          value.movieList.data!.movies![index].posterurl
                              .toString(),
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(value
                                    .movieList.data!.movies![index].ratings!)
                                .toStringAsFixed(1)),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
