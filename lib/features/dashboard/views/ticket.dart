import 'package:flutter/material.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';

import '../../events/model/event_model.dart';

class Ticket extends StatefulWidget {
  Ticket({super.key, required this.model});

  final Event model;

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket',
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: containerColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: logoColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EVENT NAME',
                            style: GoogleFonts.openSans(
                                color: faintBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.model.name!,
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              if(widget.model.type == "free")
                                Text('Free',
                                    style: GoogleFonts.openSans(
                                        color: logoColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700)),
                              if (widget.model.type == "paid")
                              Text(
                                capitalizeFirstLetter(widget.model.amount.toString()),
                                style: GoogleFonts.openSans(
                                    color: logoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Divider(
                            height: 1,
                            color: dividerColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DATE',
                                    style: GoogleFonts.openSans(
                                        color: faintBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    getStrDate(DateTime.parse(widget.model.date!),
                                        pattern: "dd MMMM, yyyy") ??
                                        '',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'TIME',
                                    style: GoogleFonts.openSans(
                                        color: faintBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    widget.model.time!,
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LOCATION',
                                style: GoogleFonts.openSans(
                                    color: faintBlack,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.model.location!,
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Divider(
                            height: 1,
                            color: dividerColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NAME',
                                style: GoogleFonts.openSans(
                                    color: faintBlack,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Charles David',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Divider(
                            height: 1,
                            color: dividerColor,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Image.asset(
                            'assets/images/scan.png',
                            height: 150,
                            width: 150,
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
