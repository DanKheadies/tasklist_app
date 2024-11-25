import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasklist_app/constants.dart';
import 'package:tasklist_app/http_service.dart';
import 'package:tasklist_app/main.dart';

mixin Func {
  HttpService httpService = HttpService();

  /// Reusable wrapper function
  Future<Response<dynamic>> sendRequest({
    required String endpoint,
    required Method method,
    Map<String, dynamic>? params,
    String? authorizationHeader,
  }) async {
    print('1');
    httpService.init(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        headers: {
          'Authorization': authorizationHeader,
        },
        receiveDataWhenStatusError: true,
      ),
    );
    print('2');

    final response = await httpService.request(
      endpoint: endpoint,
      method: method,
      params: params,
    );
    print('3');

    return response;
  }

  /// Basic / local / in-memory cache

  Future<Map<String, dynamic>> getLists(BuildContext context) async {
    Map<String, dynamic> lists = {};
    // var scaffCont = ScaffoldMessenger.of(context);

    await sendRequest(
      endpoint: allLists,
      method: Method.get,
    ).then((getLists) {
      lists = getLists.data as Map<String, dynamic>;
    }).catchError((onError) {
      if (context.mounted) {
        // scaffCont
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
            content: Text('Failed to fetch lists.'),
          ));
      }
    });

    return lists;
  }

  Future<void> createList(String name) async {
    await sendRequest(
      endpoint: newList,
      method: Method.post,
      params: {
        'name': name,
      },
    );
  }

  Future<void> getList(String id) async {
    await sendRequest(
      endpoint: singleList + id,
      method: Method.get,
    );
  }

  Future<void> updateList(
    String id,
    String name,
  ) async {
    await sendRequest(
      endpoint: singleList + id,
      method: Method.patch,
      params: {
        'name': name,
      },
    );
  }

  Future<void> deleteList(String id) async {
    await sendRequest(
      endpoint: singleList + id,
      method: Method.delete,
    );
  }

  Future<Map<String, dynamic>> getItems(BuildContext context) async {
    Map<String, dynamic> allItems = {};

    await sendRequest(
      endpoint: items,
      method: Method.get,
    ).then((getItems) {
      allItems = getItems.data as Map<String, dynamic>;
    }).catchError((onError) {
      if (context.mounted) {
        // scaffCont
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
            content: Text('Failed to fetch items.'),
          ));
      }
    });

    return allItems;
  }

  Future<void> createItem(
    String listId,
    String name,
    String description,
    bool status,
  ) async {
    await sendRequest(
      endpoint: items,
      method: Method.post,
      params: {
        'listId': listId,
        'name': name,
        'description': description,
        'status': status,
      },
    );
  }

  Future<Map<String, dynamic>> getItemsByList(
    String listId,
    BuildContext context,
  ) async {
    Map<String, dynamic> items = {};

    await sendRequest(
      endpoint: itemsByList + listId,
      method: Method.get,
    ).then((getItems) {
      items = getItems.data as Map<String, dynamic>;
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(
              content: Text('Failed to fetch items.'),
            ),
          );
      }
    });

    return items;
  }

  Future<void> updateItem(
    String id,
    String listId,
    String name,
    String description,
    bool status,
  ) async {
    await sendRequest(
      endpoint: singleItem + id,
      method: Method.patch,
      params: {
        'name': name,
        'listId': listId,
        'description': description,
        'status': status,
      },
    );
  }

  Future<void> deleteItem(String id) async {
    await sendRequest(
      endpoint: singleItem + id,
      method: Method.delete,
    );
  }

  /// Firebase

  Future<Map<String, dynamic>> getListsUsingFirebase(
    BuildContext context,
  ) async {
    Map<String, dynamic> lists = {};
    // var scaffCont = ScaffoldMessenger.of(context);

    await sendRequest(
      endpoint: firebase,
      method: Method.get,
    ).then((getLists) {
      lists = getLists.data as Map<String, dynamic>;
    }).catchError((onError) {
      if (context.mounted) {
        // scaffCont
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
            content: Text('Failed to fetch lists.'),
          ));
      }
    });

    return lists;
  }

  Future<void> createListUsingFirebase(String name) async {
    await sendRequest(
      endpoint: firebase,
      method: Method.post,
      params: {
        'name': name,
      },
    );
  }

  // Future<void> getListUsingFirebase(String id) async {
  //   await sendRequest(
  //     endpoint: firebase + id,
  //     method: Method.get,
  //   );
  // }

  Future<void> updateListUsingFirebase(
    String id,
    String name,
  ) async {
    await sendRequest(
      endpoint: firebase + id,
      method: Method.patch,
      params: {
        'name': name,
      },
    );
  }

  Future<void> deleteListUsingFirebase(String id) async {
    await sendRequest(
      endpoint: firebase + id,
      method: Method.delete,
    );
  }

  /// MongoDB

  Future<Map<String, dynamic>> getListsUsingMongoDB(
    BuildContext context,
  ) async {
    Map<String, dynamic> lists = {};
    // var scaffCont = ScaffoldMessenger.of(context);

    await sendRequest(
      endpoint: mongodb,
      method: Method.get,
    ).then((getLists) {
      lists = getLists.data as Map<String, dynamic>;
    }).catchError((onError) {
      if (context.mounted) {
        // scaffCont
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
            content: Text('Failed to fetch lists.'),
          ));
      }
    });

    return lists;
  }

  Future<void> createListUsingMongoDB(String name) async {
    await sendRequest(
      endpoint: mongodb,
      method: Method.post,
      params: {
        'name': name,
      },
    );
  }

  // Future<void> getListUsingMongoDB(String id) async {
  //   await sendRequest(
  //     endpoint: mongodb + id,
  //     method: Method.get,
  //   );
  // }

  Future<void> updateListUsingMongoDB(
    String id,
    String name,
  ) async {
    await sendRequest(
      endpoint: mongodb + id,
      method: Method.patch,
      params: {
        'name': name,
      },
    );
  }

  Future<void> deleteListUsingMongoDB(String id) async {
    await sendRequest(
      endpoint: mongodb + id,
      method: Method.delete,
    );
  }

  /// Postgresql

  Future<Map<String, dynamic>> getListsUsingPostgresql(
    BuildContext context,
  ) async {
    Map<String, dynamic> lists = {};

    await sendRequest(
      endpoint: postgresql,
      method: Method.get,
    ).then((getLists) {
      lists = getLists.data as Map<String, dynamic>;
    }).catchError((onError) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(
            content: Text('Failed to fetch lists.'),
          ));
      }
    });

    return lists;
  }

  Future<void> createListUsingPostgresql(String name) async {
    await sendRequest(
      endpoint: postgresql,
      method: Method.post,
      params: {
        'name': name,
      },
    );
  }

  // Future<void> getListUsingPostgresql(String id) async {
  //   await sendRequest(
  //     endpoint: postgresql + id,
  //     method: Method.get,
  //   );
  // }

  Future<void> updateListUsingPostgresql(
    String id,
    String name,
  ) async {
    await sendRequest(
      endpoint: postgresql + id,
      method: Method.patch,
      params: {
        'name': name,
      },
    );
  }

  Future<void> deleteListUsingPostgresql(String id) async {
    await sendRequest(
      endpoint: postgresql + id,
      method: Method.delete,
    );
  }

  Future<void> setLoginStatus(int status) async {
    await sendRequest(
      endpoint: redis,
      method: Method.post,
      params: {
        'loggedIn': status,
      },
    );
  }

  Future<void> getLoginStatus(BuildContext context) async {
    final response = await sendRequest(
      endpoint: redis,
      // endpoint: cache,
      method: Method.get,
    ).then((value) => value);
    // .catchError((err) {
    //   print('error..');
    //   print(err);
    //   return Response(
    //     data: {
    //       'derp': 'sicle',
    //     },
    //     requestOptions: RequestOptions(),
    //   );
    // });

    // Update: pointing the baseUrl from localhost to the local ip address,
    // i.e. http://192.168.1.127:8080, avoids the DioException, but it's only
    // passing back 0 atm, which is the correct value / data from redis &
    // the curl get request. Going to modify the code below to account for
    // "this is the data package."

    // User Interface logic
    if (context.mounted) {
      // if (response.data['success']) {
      //   if (response.data['message'] == 0) {
      //     Navigator.of(context).pushNamed('/sign-in');
      //   } else {
      //     Navigator.of(context).pushNamed('/lists');
      //   }
      // } else {
      //   ScaffoldMessenger.of(context)
      //     ..clearSnackBars()
      //     ..showSnackBar(
      //       SnackBar(
      //         content: Text(response.data['message']),
      //       ),
      //     );
      // }
      // if (response.data['success']) {
      //   if (response.toString() == '0') {
      //     Navigator.of(context).pushNamed('/sign-in');
      //   } else {
      //     Navigator.of(context).pushNamed('/lists');
      //   }
      // } else {
      //   print('2.4');
      //   ScaffoldMessenger.of(context)
      //     ..clearSnackBars()
      //     ..showSnackBar(
      //       SnackBar(
      //         content: Text(response.data['message']),
      //       ),
      //     );
      // }

      // print('response:');
      // print(response.data);
      // print(response.statusCode);
      // print(response.statusMessage);
      if (response.statusCode == 200) {
        if (response.data == '0') {
          Navigator.of(context).pushNamed('/sign-in');
        } else {
          Navigator.of(context).pushNamed('/lists');
        }
      } else {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(response.data),
            ),
          );
      }
    }
  }

  /// Basic Authentication

  Future<void> createUserUsingBasic(
    BuildContext context,
    String name,
    String username,
    String password,
  ) async {
    await sendRequest(
      endpoint: basicAuth,
      method: Method.post,
      params: {
        'name': name,
        'username': username,
        'password': password,
      },
    ).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          Navigator.of(context).pushNamed('/sign-in');
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Sign in please.'),
              ),
            );
        } else {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Unable to sign up..'),
              ),
            );
        }
      } else {
        print('not mounted');
      }
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text('Unable to sign up: $err'),
            ),
          );
      }
    });
  }

  Future<void> getUserUsingBasic(
    BuildContext context,
    String username,
    String password,
    bool rememberMe,
  ) async {
    await sendRequest(
      endpoint: basicAuth,
      method: Method.get,
      params: {
        'username': username,
        'password': password,
      },
      authorizationHeader:
          'Basic ${base64Encode('$username:$password'.codeUnits)}',
    ).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          customProvider.setUser(value.data as Map<String, dynamic>);
          // Note: making this await "like it should" and having a double
          // context.mounted causes the nav to not work. TODO
          // await setLoginStatus(rememberMe ? 1 : 0);
          setLoginStatus(rememberMe ? 1 : 0);
          if (context.mounted) {
            Navigator.of(context).pushNamed('/lists');
          }
        } else {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Unable to sign in..'),
              ),
            );
        }
      } else {
        print('not mounted');
      }
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text('Unable to sign in: $err'),
            ),
          );
      }
    });
  }

  Future<bool> updateUserUsingBasic(
    BuildContext context,
    String id,
    String name,
    String username,
    String newPassword,
    String oldPassword,
  ) async {
    // print('id: $id');
    // print('name: $name');
    // print('username: $username');
    // print('newPassword: $newPassword');
    // print('oldPassword: $oldPassword');
    await sendRequest(
      endpoint: basicAuth + id,
      method: Method.patch,
      params: {
        'name': name,
        'username': username,
        'password': newPassword,
      },
      authorizationHeader:
          'Basic {${base64Encode('$username:$oldPassword'.codeUnits)}}',
    ).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('User info updated.'),
              ),
            );
          return true;
        } else {
          // TODO: keeps hitting here, i.e. getting a 403 from the server
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Unable to update..'),
              ),
            );
        }
      } else {
        print('not mounted');
      }
      return false;
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to process.'),
          ),
        );
      }
      return false;
    });
    return false;
  }

  Future<void> deleteUserUsingBasic(String id) async {
    await sendRequest(
      endpoint: basicAuth + id,
      method: Method.delete,
    );
  }

  /// Bearer Authentication

  Future<void> createUserUsingBearer(
    BuildContext context,
    String name,
    String username,
    String password,
  ) async {
    await sendRequest(
      endpoint: bearerAuth,
      method: Method.post,
      params: {
        'name': name,
        'username': username,
        'password': password,
      },
    ).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          // Navigate to a sign in
        } else {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Unable to sign up..'),
              ),
            );
        }
      } else {
        print('not mounted');
      }
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text('Unable to sign up: $err'),
            ),
          );
      }
    });
  }

  Future<void> getUserUsingBearer(
    BuildContext context,
    String username,
    String password,
  ) async {
    await sendRequest(
      endpoint: bearerAuth,
      method: Method.get,
      params: {
        'username': username,
        'password': password,
      },
    ).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          // Navigate to a sign in
        } else {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Unable to sign in..'),
              ),
            );
        }
      } else {
        print('not mounted');
      }
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text('Unable to sign in: $err'),
            ),
          );
      }
    });
  }

  Future<void> updateUserUsingBearer(
    BuildContext context,
    String id,
    String name,
    String username,
    String newPassword,
    String oldPassword,
    String sessionToken,
  ) async {
    await sendRequest(
      endpoint: bearerAuth + id,
      method: Method.patch,
      params: {
        'name': name,
        'username': username,
        'password': newPassword,
      },
      authorizationHeader: 'Bearer $sessionToken',
    ).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('User info updated.'),
              ),
            );
        } else {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Unable to update..'),
              ),
            );
        }
      } else {
        print('not mounted');
      }
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to process.'),
          ),
        );
      }
    });
  }

  Future<void> deleteUserUsingBearer(
    String id,
    String sessionToken,
  ) async {
    await sendRequest(
      endpoint: bearerAuth + id,
      method: Method.delete,
      authorizationHeader: 'Bearer $sessionToken',
    );
  }

  Future<Map<String, dynamic>> getRandomAPI(BuildContext context) async {
    Map<String, dynamic> data = {};

    await sendRequest(
      endpoint: restapi,
      method: Method.get,
    ).then((value) {
      data = jsonDecode(value.data) as Map<String, dynamic>;
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch data.'),
          ),
        );
      }
    });

    return data;
  }

  /// File Upload
  Future<void> fileUpload(File file) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last)
    });

    await sendFile(
      endpoint: files,
      formData: formData,
    );
  }

  /// File Download
  Future<Response<dynamic>> fileDownload() {
    return sendRequest(
      endpoint: files,
      method: Method.get,
    );
  }

  /// Sending a file to the server
  Future<void> sendFile({
    required String endpoint,
    required FormData formData,
  }) async {
    httpService.init(BaseOptions(
      baseUrl: baseUrl,
      contentType: "multipart/form-data",
    ));
    final response = await httpService.requestFile(
      endpoint: endpoint,
      formData: formData,
    );
    return response;
  }
}
