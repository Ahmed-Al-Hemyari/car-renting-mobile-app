import 'package:car_renting/services/Booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final Color? statusColor;
    final Color? statusTextColor;

    switch (booking.status) {
      case 'pending':
        statusColor = Colors.yellow[100];
        statusTextColor = Colors.yellow[700];
      case 'confirmed':
        statusColor = Colors.blue[100];
        statusTextColor = Colors.blue[700];
      case 'cancelled':
        statusColor = Colors.red[100];
        statusTextColor = Colors.red[700];
      case 'refused':
        statusColor = Colors.redAccent[100];
        statusTextColor = Colors.redAccent[700];
      case 'active':
        statusColor = Colors.green[100];
        statusTextColor = Colors.green[700];
      case 'expired':
        statusColor = Colors.grey[100];
        statusTextColor = Colors.grey[700];
      case 'late':
        statusColor = Colors.orange[100];
        statusTextColor = Colors.orange[700];
      default:
        statusColor = Colors.grey[100];
        statusTextColor = Colors.grey[700];
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- Car image ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.asset(
                    'assets/images/no-image-car.svg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 8),

                // --- Info column ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top section: Booking ID
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: 'Booking '),
                                  TextSpan(
                                    text: '#${booking.id}',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // --- Car name (flexible, wraps text) ---
                      Text.rich(
                        TextSpan(
                          text: booking.carName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' (${booking.carCategory})',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // --- Dates ---
                      Row(
                        spacing: 5,
                        children: [
                          Row(
                            children: [
                              Text(
                                'From: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Tajawal',
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '${booking.startDate.year}-${booking.startDate.month}-${booking.startDate.day}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Tajawal',
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                '${booking.endDate.year}-${booking.endDate.month}-${booking.endDate.day}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- Status pill ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Text(
                        booking.status,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500,
                          color: statusTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                booking.rated == false &&
                        (booking.status == 'confirmed' ||
                            booking.status == 'pending' ||
                            booking.status == 'active')
                    ? ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.cancel, size: 16),
                        label: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 13, fontFamily: 'Tajawal'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              booking.status == 'pending' ||
                                  booking.status == 'confirmed'
                              ? Colors.red
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.cancel, size: 16),
                        label: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 13, fontFamily: 'Tajawal'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              booking.status == 'pending' ||
                                  booking.status == 'confirmed'
                              ? Colors.red
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



                          // const SizedBox(height: 8),

                          // // --- Dates ---
                          // Row(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Icon(
                          //           Icons.calendar_today,
                          //           size: 16,
                          //           color: Colors.grey[600],
                          //         ),
                          //         const SizedBox(width: 4),
                          //         Text(
                          //           'From: ${booking.startDate.year}-${booking.startDate.month}-${booking.startDate.day}',
                          //           style: TextStyle(
                          //             fontSize: 14,
                          //             fontFamily: 'Tajawal',
                          //             color: Colors.grey[700],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     Row(
                          //       children: [
                          //         Icon(
                          //           Icons.calendar_today_outlined,
                          //           size: 16,
                          //           color: Colors.grey[600],
                          //         ),
                          //         const SizedBox(width: 4),
                          //         Text(
                          //           'To: ${booking.endDate.year}-${booking.endDate.month}-${booking.endDate.day}',
                          //           style: TextStyle(
                          //             fontSize: 14,
                          //             fontFamily: 'Tajawal',
                          //             color: Colors.grey[700],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),