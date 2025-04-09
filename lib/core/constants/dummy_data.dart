part of 'constants.dart';

List<Dog> dogsList = [
  Dog(
    id: 1,
    name: 'Dachshund',
    gender: true,
    breed: 'Mixed Breed',
    age: '10-12',
    behavior: 'Confident',
    images: [
      getImagePath('dachshund_1'),
      getImagePath('dachshund_1'),
      getImagePath('dachshund_1'),
      getImagePath('dachshund_1'),
    ],
    habits: 'Cuddle. Love to chase a ball',
    specialNeeds: 'Sweet dog. No special needs',
    isCurrentDog: true,
  ),
  Dog(
    id: 2,
    name: 'Dachshund',
    gender: false,
    breed: 'Mixed Breed',
    age: '10-12',
    behavior: 'Confident',
    images: [
      getImagePath('dachshund_2'),
      getImagePath('dachshund_2'),
      getImagePath('dachshund_2'),
      getImagePath('dachshund_2'),
    ],
    habits: 'Cuddle. Love to chase a ball',
    specialNeeds: 'Sweet dog. No special needs',
  ),
  Dog(
    id: 3,
    name: 'Dachshund',
    gender: true,
    breed: 'Mixed Breed',
    age: '10-12',
    behavior: 'Confident',
    images: [
      getImagePath('dachshund_3'),
      getImagePath('dachshund_3'),
      getImagePath('dachshund_3'),
      getImagePath('dachshund_3'),
    ],
    habits: 'Cuddle. Love to chase a ball',
    specialNeeds: 'Sweet dog. No special needs',
  ),
  Dog(
    id: 4,
    name: 'Dachshund',
    gender: false,
    breed: 'Mixed Breed',
    age: '10-12',
    behavior: 'Confident',
    images: [
      getImagePath('dachshund_4'),
      getImagePath('dachshund_4'),
      getImagePath('dachshund_4'),
      getImagePath('dachshund_4'),
    ],
    habits: 'Cuddle. Love to chase a ball',
    specialNeeds: 'Sweet dog. No special needs',
  ),
  Dog(
    id: 5,
    name: 'Dachshund',
    gender: false,
    breed: 'Mixed Breed',
    age: '10-12',
    behavior: 'Confident',
    images: [
      getImagePath('dachshund_5'),
      getImagePath('dachshund_5'),
      getImagePath('dachshund_5'),
      getImagePath('dachshund_5'),
    ],
    habits: 'Cuddle. Love to chase a ball',
    specialNeeds: 'Sweet dog. No special needs',
  ),
];

List<Human> humansList = [
  Human(
    name: 'Christian Martinen',
    image: getImagePath('chris_martinen'),
    distance: 2.7,
    dogs: [dogsList[0]],
  ),
  Human(name: 'Robert Wall', image: null, distance: 2.7, dogs: [dogsList[1]]),
  Human(name: 'Jeanne Kohn', image: null, distance: 2.7, dogs: [dogsList[2]]),
  Human(name: 'Yeal Kaufman', image: null, distance: 2.7, dogs: [dogsList[3]]),
];

Dog currentDog = dogsList[0];
