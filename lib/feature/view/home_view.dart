import 'package:by_carbonmail/feature/model/post_model.dart';
import 'package:by_carbonmail/feature/service/post_service.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../products/text/app_texts.dart';
import '../../products/text/utility/app_utility.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int pageIndex = 0;
  PostService _postService = PostService();
  List<PostModel>? _postModel;
  bool isLoading = false;
  Future<void> init() async {
    _postModel = await _postService.fetchPost();
    changeLoading();
  }

  void onTap(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtility().backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: AppUtility().titlePadding,
              child: _buildTitle(context),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: AppUtility().subscriptionsPadding,
              child: _buildRowArea(),
            ),
          ),
          Expanded(flex: 8, child: _buildList()),
          Expanded(
            flex: 1,
            child: _buildNavigationBar(),
          )
        ],
      ),
    );
  }

  BottomNavigationBar _buildNavigationBar() {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "MailBox",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.nature_people_outlined), label: "")
        ],
        currentIndex: pageIndex,
        onTap: onTap);
  }

  SingleChildScrollView _buildList() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: isLoading
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      trailing: RightDeleteButton(),
                      title: Text(_postModel?[index].name ?? " boş"),
                      subtitle:
                          Text(_postModel?[index].email ?? " bu data boş"),
                    ),
                  ),
                );
              })
          : const Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
    );
  }

  SizedBox _buildTitle(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.5),
      child: Text(AppTexts().homeTitle,
          textAlign: TextAlign.left,
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontSize: 32,
              color: AppUtility().textColor,
              fontWeight: FontWeight.bold)),
    );
  }

  Row _buildRowArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppTexts().subsText,
          style: TextStyle(
              color: AppUtility().textColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        Container(
          width: 130,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppUtility().cleanedButtonColor,
          ),
          child: Text(
            AppTexts().cleanedText,
            style: TextStyle(color: AppUtility().textColor, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class RightDeleteButton extends StatelessWidget {
  const RightDeleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.delete,
          color: Color.fromARGB(255, 33, 112, 248),
        ),
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color.fromARGB(64, 68, 137, 255)),
    );
  }
}
