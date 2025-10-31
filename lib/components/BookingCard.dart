import 'package:car_renting/services/Booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  void _cancelBooking(BuildContext context, int bookingId) async {
    final url = "http://10.0.2.2:8000/api/bookings/$bookingId";

    try {
      await Booking.cancelBooking(bookingId, url);

      Navigator.pushReplacementNamed(context, '/profile');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking cancelled successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to cancel booking. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showConfirmationDialog(BuildContext context, int bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Cancelling'),
          content: Text('Are you sure you want to cancel booking?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        _cancelBooking(context, bookingId);
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? statusColor;
    Color? statusTextColor;

    switch (widget.booking.status) {
      case 'pending':
        statusColor = Colors.yellow[100];
        statusTextColor = Colors.yellow[700];
        break;
      case 'confirmed':
        statusColor = Colors.blue[100];
        statusTextColor = Colors.blue[700];
        break;
      case 'cancelled':
        statusColor = Colors.red[100];
        statusTextColor = Colors.red[700];
        break;
      case 'refused':
        statusColor = Colors.redAccent[100];
        statusTextColor = Colors.redAccent[700];
        break;
      case 'active':
        statusColor = Colors.green[100];
        statusTextColor = Colors.green[700];
        break;
      case 'expired':
        statusColor = Colors.grey[100];
        statusTextColor = Colors.grey[700];
        break;
      case 'late':
        statusColor = Colors.orange[100];
        statusTextColor = Colors.orange[700];
        break;
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Car image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Builder(
                    builder: (context) {
                      final imageUrl = widget.booking.carImage;
                      final id = widget.booking.carId;

                      if (imageUrl.isEmpty) {
                        return SvgPicture.asset(
                          'assets/images/no-image-car.svg',
                          key: ValueKey(id),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      }

                      if (imageUrl.toLowerCase().endsWith('.svg')) {
                        return SvgPicture.network(
                          imageUrl,
                          key: ValueKey(id),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          placeholderBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      }

                      return Image.network(
                        imageUrl,
                        key: ValueKey(id),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            'assets/images/no-image-car.svg',
                            key: ValueKey(id),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Booking ID
                      RichText(
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
                              text: '#${widget.booking.id}',
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Car name + category
                      Text.rich(
                        TextSpan(
                          text: widget.booking.carName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' (${widget.booking.carCategory})',
                              style: TextStyle(
                                fontSize: 17,
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

                      // Dates
                      Row(
                        children: [
                          Text(
                            'From: ${widget.booking.startDate.year}-${widget.booking.startDate.month}-${widget.booking.startDate.day}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontFamily: 'Tajawal',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'To: ${widget.booking.endDate.year}-${widget.booking.endDate.month}-${widget.booking.endDate.day}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            // Bottom row: status + action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status pill
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
                    widget.booking.status,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: statusTextColor,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),

                // Action button
                widget.booking.rated == false &&
                        widget.booking.status == 'completed'
                    ? ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.rate_review, size: 16),
                        label: const Text(
                          'Rate',
                          style: TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
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
                        onPressed:
                            widget.booking.status == 'pending' ||
                                widget.booking.status == 'confirmed'
                            ? () => _showConfirmationDialog(
                                context,
                                widget.booking.id,
                              )
                            : null,
                        icon: const Icon(Icons.cancel, size: 16),
                        label: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              widget.booking.status == 'pending' ||
                                  widget.booking.status == 'confirmed'
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
