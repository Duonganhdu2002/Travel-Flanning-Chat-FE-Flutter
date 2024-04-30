import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/ultils/app_bar.dart';
import 'package:readmore/readmore.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'lib/images/Detail_image.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 620,
          ),
          Column(
            children: [
              const CustomBar(
                isTransparent: true,
                leftWidget: BackIcon(),
                centerWidget: Text(
                  "Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: SingleChildScrollView(
                      
                      child: Column(
                        children: [
                          
                          //Ten dia diem, Avatar nguoi dung
                          
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Niladri Reservoir',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tekergat, Sunamgnj',
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage('lib/images/User_img.png'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //Dia diem, danh gia, Tien
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    
                                  ),
                                  Text(
                                    'Tekergat',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            
                                  SizedBox(
                                    width: 24,
                                  ),
                                  //rating
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text('4.7'),
                                  Text(
                                    '(2498)',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            
                                  SizedBox(
                                    width: 24,
                                  ),
                                  //Price
                                  Icon(
                                    Icons.attach_money,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    '59/',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Text(
                                    'Person',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),


                          //Hinh Anh lien quan
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 26),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        'lib/images/Detail_img1.jpg',
                                        fit: BoxFit.cover,
                                        width: 64,
                                        height: 64,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 26),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        'lib/images/Detail_img2.jpg',
                                        fit: BoxFit.cover,
                                        width: 64,
                                        height: 64,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 26),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        'lib/images/Detail_img3.jpg',
                                        fit: BoxFit.cover,
                                        width: 64,
                                        height: 64,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15),
                                      image: const DecorationImage(
                                        image: AssetImage('lib/images/Detail_img4.jpg'),
                                        fit: BoxFit.fill,
                                        opacity: 0.6,
                                      ), 
                                    ),
                                    child: const Text(
                                      "+16",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),    
                                    ),
                                  ),  
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          // Mô tả địa điểm
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Destination',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                                
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              ReadMoreText("You will get a complete travel package on the beaches. Packages in the form of airline tickets, recommended Hotel rooms, Transportation, Have you ever been on holiday to the Greek ETC , You will get a complete travel package on the beaches. Packages in the form of airline tickets, recommended Hotel rooms, Transportation, Have you ever been on holiday to the Greek ETC.",
                               trimMode: TrimMode.Line,
                               trimLines: 3,
                               colorClickableText: Colors.deepOrangeAccent,
                               trimCollapsedText: "Read More",
                               trimExpandedText: "Show Less",
                               
                               )
                              
                             
                            ],
                          ),
                         
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.yellow[600],
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: Text("Book now"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
