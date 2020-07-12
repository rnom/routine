# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname  |string|null: false|
|bodyweight|integer|null: false|
|height    |float|null: false|
|bmi       |float|null: false|
|email     |string|null: false, unique: true|
|password  |string|null: false|

### Association
- has_many :favorites, dependent: :destroy
- has_many  :meals, dependent: :destroy
<!-- - has_many  :performances,  through:  :meals -->
- has_many  :workouts, dependent: :destroy
<!-- - has_many  :performances,  through:  :workouts -->
- has_many :comments, dependent: :destroy
<!-- - has_many  :performances,  through:  :comments -->


## mealsテーブル

|Column|Type|Options|
|------|----|-------|
|name         |string |null: false, index: true|
|protein      |float  |null: false|
|fat          |float  |null: false|
|carb         |float  |null: false|
|cal          |float  |null: false|
|user_id      |integer|null: false, foreign_key: true|

### Association
- has_many   :favorites, dependent: :destroy
- has_many   :images, dependent: :destroy
- belongs_to :user
- belongs_to :performance


## workoutsテーブル

|Column|Type|Options|
|------|----|-------|
|menu         |string |null: false, index: true|
|weight       |integer|null: false|
|set          |integer|null: false|
|bodypart     |string |null: false|
|cal          |integer||
|user_id      |integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :performance


## performancesテーブル

|Column|Type|Options|
|------|----|-------|
|meal_id     |integer|null: false, foreign_key: true|
|workout_id  |integer|null: false, foreign_key: true|

### Association
- has_many    :workouts
- has_many    :meals
- has_many    :comments
- belongs_to  :users,  through:  :workouts
- belongs_to  :users,  through:  :meals
- belongs_to  :users,  through:  :comments


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image    |string |null: false|
|meal_id  |integer|null: false, foreign_key: true|

### Association
- belongs_to :meal 


## favoritesテーブル

|Column|Type|Options|
|------|----|-------|
|meal_id     |integer|null: false, foreign_key: true|
|user_id     |integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :meal


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|comment           |text   |null: false|
|performance_id    |integer|null: false, foreign_key: true|
|user_id           |integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :performance