import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class WebSocketService {
  late io.Socket socket;

  WebSocketService() {
    // Initialize the socket
    socket = io.io('http://10.0.2.2:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  }

  void connect(
    String userId,
    Function(List<Map<String, String>>) onInitialRequests,
    Function(Map<String, String>) onFriendRequestReceived,
    Function(Map<String, String>) onFriendRequestAccepted,
    Function(Map<String, String>) onFriendRequestRejected,
  ) {
    socket.connect();

    socket.onConnect((_) {
      debugPrint('Connected to WebSocket');
      socket.emit('join', userId);
    });

    socket.onConnectError((error) {
      debugPrint('Connection error: $error');
    });

    socket.onError((error) {
      debugPrint('Socket error: $error');
    });

    socket.onDisconnect((reason) {
      debugPrint('Disconnected from WebSocket: $reason');
    });

    socket.on('initial_friend_requests', (data) {
      debugPrint('Initial friend requests: $data');
      try {
        List<Map<String, String>> requests = List<Map<String, String>>.from(
          data.map<Map<String, String>>((item) => {
                'userId': item['_id'] as String,
                'username': item['username'] as String,
              }),
        );
        onInitialRequests(requests);
      } catch (e) {
        debugPrint('Error handling initial friend requests: $e');
      }
    });

    socket.on('receive_friend_request', (data) {
      debugPrint('Received friend request: $data');
      try {
        onFriendRequestReceived({
          'userId': data['senderId'] as String,
          'username': data['username'] as String,
        });
      } catch (e) {
        debugPrint('Error handling received friend request: $e');
      }
    });

    socket.on('friend_request_accepted', (data) {
      debugPrint('Friend request accepted: $data');
      try {
        onFriendRequestAccepted({
          'userId': data['userId'] as String,
          'friendId': data['friendId'] as String,
        });
      } catch (e) {
        debugPrint('Error handling accepted friend request: $e');
      }
    });

    socket.on('friend_request_rejected', (data) {
      debugPrint('Friend request rejected: $data');
      try {
        onFriendRequestRejected({
          'userId': data['userId'] as String,
          'friendId': data['friendId'] as String,
        });
      } catch (e) {
        debugPrint('Error handling rejected friend request: $e');
      }
    });
  }

  void sendFriendRequest(String senderId, String receiverId, String username) {
    debugPrint('Sending friend request from $senderId to $receiverId');
    try {
      socket.emit('send_friend_request', {
        'senderId': senderId,
        'receiverId': receiverId,
        'username': username,
      });
    } catch (e) {
      debugPrint('Error sending friend request: $e');
    }
  }

  void acceptFriendRequest(String userId, String friendId) {
    debugPrint('Accepting friend request from $friendId to $userId');
    try {
      socket.emit('accept_friend_request', {
        'userId': userId,
        'friendId': friendId,
      });
    } catch (e) {
      debugPrint('Error accepting friend request: $e');
    }
  }

  void rejectFriendRequest(String userId, String friendId) {
    debugPrint('Rejecting friend request from $friendId to $userId');
    try {
      socket.emit('reject_friend_request', {
        'userId': userId,
        'friendId': friendId,
      });
    } catch (e) {
      debugPrint('Error rejecting friend request: $e');
    }
  }

  void disconnect() {
    debugPrint('Disconnecting from WebSocket');
    socket.disconnect();
  }
}
