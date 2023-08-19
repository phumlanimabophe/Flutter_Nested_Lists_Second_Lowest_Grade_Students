import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Positioned(
              top: 0.0,bottom: 0.0,left: 0.0,right: 0.0,
              child: Image.network('https://images.pexels.com/photos/2361312/pexels-photo-2361312.jpeg',fit: BoxFit.cover)
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Nested Lists: Second Lowest Grade Students',
               
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 48, 0, 151),
                  fontFamily: 'Roboto', 
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 34, 216, 140),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
            
                ),
              ),
              
              backgroundColor: Colors.blueGrey,
              centerTitle: true,
              elevation: 8,
              toolbarHeight: 80, 
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30), 
                ),
              ),
            ),
            body: const StudentInputForm(),
          ),
        ],
      ),
    );
  }
}

class StudentInputForm extends StatefulWidget {
  const StudentInputForm({super.key});

  @override
  StudentInputFormState createState() => StudentInputFormState();
}

class StudentInputFormState extends State<StudentInputForm> {
  Map allStudentsLists={
    "class 1":[
    Student(name: 'Liam', grade: 90.0),
    Student(name: 'Emma', grade: 85.5),
    Student(name: 'Noah', grade: 88.0),
    Student(name: 'Olivia', grade: 85.5),
    Student(name: 'Aiden', grade: 86.5),
    Student(name: 'Ava', grade: 92.0),
    Student(name: 'Ethan', grade: 87.0),
    Student(name: 'Sophia', grade: 84.0),
    ],
    "Class 2": [
      Student(name: 'John', grade: 85.5),
      Student(name: 'Alice', grade: 90.0),
      Student(name: 'Kona', grade: 80.0),
      Student(name: 'Carol', grade: 78.5),
      Student(name: 'Eve', grade: 88.0),
      Student(name: 'Frank', grade: 80.0),
      Student(name: 'Grace', grade: 85.5),
      Student(name: 'Max', grade: 90.0),
    ],
    "Class 3": [
      Student(name: 'David', grade: 92.0),
      Student(name: 'Emma', grade: 79.5),
      Student(name: 'Jack', grade: 88.5),
      Student(name: 'Lily', grade: 85.0),
      Student(name: 'Noah', grade: 91.0),
      Student(name: 'Olivia', grade: 87.5),
      Student(name: 'Sophia', grade: 83.0),
      Student(name: 'William', grade: 86.0),
    ],
    "Class 4": [
      Student(name: 'Michael', grade: 89.5),
      Student(name: 'Abigail', grade: 82.0),
      Student(name: 'Ryan', grade: 91.5),
      Student(name: 'Ava', grade: 88.0),
      Student(name: 'Daniel', grade: 83.5),
      Student(name: 'Sofia', grade: 85.5),
      Student(name: 'Ethan', grade: 92.0),
      Student(name: 'Emily', grade: 86.5),
    ],
    "Class 5": [
      Student(name: 'James', grade: 80.5),
      Student(name: 'Isabella', grade: 87.0),
      Student(name: 'Benjamin', grade: 85.5),
      Student(name: 'Mia', grade: 89.0),
      Student(name: 'William', grade: 84.5),
      Student(name: 'Elizabeth', grade: 88.5),
      Student(name: 'Oliver', grade: 92.5),
      Student(name: 'Aiden', grade: 91.0),
    ],
  };
   List<Student>? allStudents;


  List<String> selectedStudents = []; 
  List<String> secondLowestGradeStudents = []; 


  dynamic findSecondLowestGrade() {
    List<Student> sortedStudents = List.from(allStudents!)..sort((a, b) => a.grade.compareTo(b.grade));

    double? secondLowestGrade;
    for (int i = 1; i < sortedStudents.length; i++) {
      if(selectedStudents.contains(sortedStudents[i].name)){
        if (sortedStudents[i].grade > sortedStudents[0].grade) {
          secondLowestGrade = sortedStudents[i].grade;
          break;
        }
      }

    }

    return secondLowestGrade; 
  }



  bool isChecked=false;
  String currentClass="";
  void toggleSelectAll(bool? checked) {

    setState(() {

      isChecked=checked!;
      if (isChecked) {
        selectedStudents = allStudents!.map((student) => student.name).toList();
      } else {
        selectedStudents.clear();
      }


    });
    if (kDebugMode) {
      print(selectedStudents.toList());
    }
  }

  void findSecondLowestGradeStudents() {

    List<String> result = _findSecondLowestGradeStudents(selectedStudents);
    setState(() {
      secondLowestGradeStudents = result;
    });
  }

  double? secondLowestGrade;
  List<String> _findSecondLowestGradeStudents(List<String> selectedStudents) {
     secondLowestGrade = findSecondLowestGrade(); 

    List<String> secondLowestGradeStudents = [];
    for (Student student in allStudents!) {
      if (student.grade == secondLowestGrade && selectedStudents.contains(student.name)) {
        secondLowestGradeStudents.add(student.name);
      }
    }

    return secondLowestGradeStudents;
  }
bool reseting=false;
  @override
  void initState() {
    // TODO: implement initState
    if(allStudents==null) {
      currentClass="class 1";
      allStudents = allStudentsLists[currentClass];

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds:5 ), () {
      if(reseting){
        setState(() {
             reseting=false;
             });
      }
    });

    if(reseting){
      return Center(
        child: Card(
          child: Container(
            height: 100.0,
            width:100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressIndicator(),
                Text("Loading...")
              ],
            ),
          ),
        ),
      );
    }

    return Builder(
      builder: (context) {
        return Column(
          children: [
            
            const SizedBox(height: 16),
            Row(
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: Checkbox(
                          value: isChecked,
                          onChanged: toggleSelectAll,
                          fillColor:MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0))
                        ),
                      ),
                      const Text(
                  'All',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                )
                    ],
                  ),
                ),
                
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 76, 0, 255))),
                    onPressed: findSecondLowestGradeStudents,
                    child:  Text('Find Second Lowest Grade Students',style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),),
                  ),
                ),
                Card(
                  child: IconButton(icon:Icon(Icons.refresh),onPressed: (){
              setState(() {
                              reseting=true;
                            });
            },),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width*1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                    itemCount: allStudentsLists.keys.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: ElevatedButton(onPressed: (){

                      }, child: Row(
                        children: [
                          Checkbox(
                            value: currentClass==allStudentsLists.keys.toList()[index],
                            onChanged: (isChecked) {
                              setState(() {
                                toggleSelectAll(false);
                                currentClass=allStudentsLists.keys.toList()[index];
                                allStudents = allStudentsLists[currentClass];
                              });

                            },
                          ),
                          Text("${allStudentsLists.keys.toList()[index]}"),
                        ],
                      )),
                    );
                  }
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allStudents!.length,
                itemBuilder: (context, index) {

                  return Row(
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            dynamic student;
                            return StatefulBuilder(
                                builder: (context,state) {

                                  Future.delayed(Duration(milliseconds: int.parse("${index*1}00")), () {

                                     student = allStudents![index];
                                     try{
                                       state((){});
                                     }catch(error){
                                       if (kDebugMode) {
                                         print("state disposed");
                                       }
                                     }

                                  });

                                  if(student==null){
                                    return Container();
                                  }

                                return Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  color: Color.fromARGB(221, 0, 0, 0), 
                                  child: ListTile(
                                    leading: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white, 
                                        checkboxTheme: CheckboxThemeData(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0), 
                                          ),
                                        ),
                                      ),
                                      child: Checkbox(
                                        value: selectedStudents.contains(student.name),
                                        onChanged: (isChecked) {
                                          setState(() {
                                            if (isChecked != null) {
                                              if (isChecked) {
                                                selectedStudents.add(student.name);
                                              } else {
                                                selectedStudents.remove(student.name);
                                              }
                                              if (kDebugMode) {
                                                print(selectedStudents.toList());
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          student.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white, 
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${student.grade.toString()}%",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 0, 255, 242),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            );
                          }
                        ),
                      ),
                      Expanded(child: Container())
                   
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            Row(
              children: [
                Builder(
                  builder: (context) {
                    return Card(
                      color: Colors.white.withOpacity(0.8),
                      child: SizedBox(
                        width: 400.0,
                        height: 150.0,
                        child: Row(
                          children: [
                            
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                child: const Text(
                                  'Grade:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),

                                  Expanded(
                                    child: Text(
                                      secondLowestGrade==null
                                          ? 'Not Selected'
                                          : '${secondLowestGrade.toString()}%',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Students:',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),

                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: secondLowestGradeStudents.length,
                                      itemBuilder: (context, index) {
                                        
                                        return ListTile(
                                          title: Center(child: Text(secondLowestGradeStudents[index])),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),

          ],
        );
      }
    );
  }
}

class Student {
  final String name;
  final double grade;

  Student({required this.name, required this.grade});
}
