import 'package:flutter/material.dart';
import 'package:todo/database/db_helper.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key,required this.todo,required this.onPressed,required this.deleteTodo});
  final Map<String,dynamic>todo;
final  void Function()  onPressed;
final  void Function()  deleteTodo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: ListTile(
        onTap: onPressed,
        contentPadding: EdgeInsets.all(10),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor:todo[DbHelper.COLUMN_NOTE_ISCOMPLETED]==0? Colors.white:Colors.grey.shade300,
        leading:todo[DbHelper.COLUMN_NOTE_ISCOMPLETED]==0? Icon(Icons.check_box_outline_blank,color: Colors.lightGreen,):Icon(Icons.check_box,color: Colors.lightGreen,),
         title:Text('${todo[DbHelper.COLUMN_NOTE_TITLE]}',style: TextStyle(
          fontSize: 23,
          fontWeight:todo[DbHelper.COLUMN_NOTE_ISCOMPLETED]==0?  FontWeight.w500:FontWeight.w200,
          decoration:todo[DbHelper.COLUMN_NOTE_ISCOMPLETED]==1? TextDecoration.lineThrough: null,
         ),) ,
         trailing: IconButton(onPressed: deleteTodo, icon: Icon(Icons.delete,color: Colors.red.shade400,size: 35,)),
      ),
    );
  }
}