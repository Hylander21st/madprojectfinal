import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class Controller extends GetxController {
  var _cart = {}.obs;
  VideoPlayerController videoController;
  Rx<File> profileImage = Rx<File>(); // New variable to hold profile picture

  // Getters
  get cart => _cart;
  int get cartCount => _cart.length;
  int get count => _cart.isNotEmpty
      ? _cart.values
          .map((item) => item['product_quantity'] ?? 0)
          .reduce((a, b) => (a ?? 0) + (b ?? 0))
      : 0;

  // Functions for managing cart
  void addToCart(index, shoesize) {
    if (_cart.containsKey(index)) {
      _cart[index]['product_quantity'] += 1;
    } else {
      _cart[index] = {"product_quantity": 1, "product_shoesize": shoesize};
    }
    _cart.refresh();
  }

  void removeFromCart(index) {
    if (_cart.containsKey(index)) {
      if (_cart[index]['product_quantity'] > 0) {
        _cart[index]['product_quantity'] -= 1;
      }
    }
    _cart.refresh();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
    }
  }

  // Video player functions
  void initializeVideo(String videoUrl) {
    videoController = VideoPlayerController.network(videoUrl);
    videoController.initialize();
  }

  void playVideo() {
    if (videoController != null) {
      videoController.play();
    }
  }

  void pauseVideo() {
    if (videoController != null) {
      videoController.pause();
    }
  }

  void disposeVideo() {
    if (videoController != null) {
      videoController.dispose();
      videoController = null;
    }
  }

  // Function to fetch challenges from ChallengePage
  void fetchChallenges(List<String> challenges) {
    if (challenges != null && challenges.isNotEmpty) {
      _cart['challenge1'] = challenges.length > 0 ? challenges[0] : '';
      _cart['challenge2'] = challenges.length > 1 ? challenges[1] : '';
      _cart.refresh();
    }
  }

  // Function to update profile picture
  void setProfileImage(File image) {
    profileImage.value = image;
  }

  
}
