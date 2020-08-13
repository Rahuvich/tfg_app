import 'dart:async';
import 'dart:convert';

import 'package:jumpets_app/data/api_base_helper.dart';
import 'package:jumpets_app/models/models.dart';

class AdsProvider {
  final ApiBaseHelper _api;

  AdsProvider() : this._api = ApiBaseHelper();

  Future<dynamic> getPaginatedAds(
      {Category category,
      int first,
      String after,
      int photosWidth,
      int photosHeight,
      int thumbnailWidth,
      int thumbnailHeight}) async {
    return _api.post({
      'query': '''{
    ads(category: $category, first: $first, after: \"$after\") {
      totalCount
      edges{
        node{
          id: _id
          tags
          photos(options: {width: $photosWidth, height: $photosHeight})
          ... on ProductAd {
            title
            description
            price
            type: __typename
          }
          ... on ServiceAd {
            title
            description
            priceHour
            type: __typename
          }
          ... on AnimalAd {
            name
            description
            activityLevel
            birthDate
            male
            adoptionTax
            weight
            personality
            mustKnow
            deliveryInfo
            breed
            ... on Dog {
              size
              type
            }
            ... on OtherAnimal {
              type
            }
          }
          createdAt
          creator {
            id: _id
            type: __typename
            thumbnail(options: {
              width: $thumbnailWidth,
              height: $thumbnailHeight
            })
            name
            address
            email
            phone
            ... on Protectora {
              web
            }
            ... on Profesional {
              web
            }
            createdAt
            updatedAt
          }
        }
        cursor
      }
      pageInfo {
        hasPreviousPage
        hasNextPage
        endCursor
      }
    }
  }'''
    });
  }

  Future<dynamic> searchAds(
      {String name,
      List<String> tags,
      String breed,
      DogSize size,
      List<DeliveryStatus> deliveryInfo,
      bool male,
      ActivityLevel activityLevel,
      AnimalType type,
      String creator}) async {
    return _api.post({
      'query': '''{
    searchAds(filters: {
      creator: "$creator",
      name: $name,
      tags: $tags,
      breed: $breed,
      size: $size,
      deliveryInfo: $deliveryInfo,
      male: $male,
      activityLevel: $activityLevel,
      type: $type
    }) {
          id: _id
          tags
          photos
          ... on ProductAd {
            title
            description
            price
            type: __typename
          }
          ... on ServiceAd {
            title
            description
            priceHour
            type: __typename
          }
          ... on AnimalAd {
            name
            description
            activityLevel
            birthDate
            male
            adoptionTax
            weight
            personality
            mustKnow
            deliveryInfo
            breed
            ... on Dog {
              size
              type
            }
            ... on OtherAnimal {
              type
            }
          }
          createdAt
          creator {
            id: _id
            type: __typename
            thumbnail
            name
            address
            email
            phone
            ... on Protectora {
              web
            }
            ... on Profesional {
              web
            }
            createdAt
            updatedAt
          }
    }
  }'''
    });
  }
}