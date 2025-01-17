import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/R.dart';
import 'package:flutter_app/src/config/app_colors.dart';
import 'package:flutter_app/src/config/app_link.dart';
import 'package:flutter_app/src/util/open_utils.dart';
import 'package:flutter_app/ui/other/listview_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github/github.dart';

class ContributorsPage extends StatelessWidget {
  final github = GitHub();
  final repositorySlug =
      RepositorySlug(AppLink.githubOwner, AppLink.githubName);

  ContributorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.current.Contribution),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  R.current.projectLink,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      const url = AppLink.gitHub;
                      OpenUtils.launchURL(url);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                R.current.github,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: const [Text(AppLink.gitHub)],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  R.current.Contributors,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          FutureBuilder<List<Contributor>>(
            future:
                github.repositories.listContributors(repositorySlug).toList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Contributor>> snapshot) {
              if (snapshot.hasData) {
                List<Contributor> contributorList = snapshot.data!;
                return ListView.builder(
                  itemCount: contributorList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Contributor contributor = contributorList[index];
                    return InkWell(
                      onTap: () {
                        OpenUtils.launchURL(contributor.htmlUrl!);
                      },
                      child: WidgetAnimator(
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: contributor.avatarUrl!,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 15.0,
                                    backgroundImage: imageProvider,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              Text(contributor.login!)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Icon(Icons.error),
                );
              }
              return const Center(
                child: SpinKitDoubleBounce(
                  color: AppColors.mainColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
