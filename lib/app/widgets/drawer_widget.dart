import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/routes/app_routes.dart';

class DrawerWidget extends StatelessWidget {
  final int selectedItem;
  DrawerWidget(this.selectedItem, {Key? key}) : super(key: key);

  final List<List<String>> _items = [
    [
      'Tarefas do Dia',
      AppRoutes.TASKS_OF_THE_DAY_ROUTE,
    ],
    [
      'Histórico',
      AppRoutes.TASK_HISTORY_ROUTE,
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.3),
            blurRadius: 30.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 5.0,
            ),
            child: Text(
              'Mini Tarefas',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
          Column(
            children: List.generate(
              _items.length,
              (itemIndex) {
                return Container(
                  decoration: BoxDecoration(
                    color: selectedItem == itemIndex
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    boxShadow: selectedItem == itemIndex
                        ? <BoxShadow>[
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              blurRadius: 20.0,
                              spreadRadius: 0.0,
                            ),
                          ]
                        : null,
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.offNamed(_items[itemIndex][1]);
                    },
                    trailing: selectedItem == itemIndex
                        ? Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          )
                        : null,
                    tileColor: selectedItem == itemIndex
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    title: Text(
                      _items[itemIndex][0],
                      style: TextStyle(
                        color: selectedItem == itemIndex
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Colors.blueGrey.withOpacity(0.6),
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
