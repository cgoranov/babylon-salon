User
    has_many :appointments
    has_many :barbers, through: :appointments
    has_many :favorite_barbers   
    has_many :favorite_barbers, through: :favorite_barbers

    username
    email
    password
    uid
    provider

Barber
    has_many :appointments
    has_many :users, through: :appointments

    first_name
    last_name


Appointment
    belongs_to :user
    belongs_to :barber

    :user_id
    :barber_id



Favorite_Barber
    belongs_to :user
    belongs_to :barber

    :user_id
    :barber_id


