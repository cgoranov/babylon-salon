User
    has_many :appointments
    has_many :barbers, through: :appointments
    has_many :favorite_barbers   
    has_many :favorite_barbers, through: :favorite_barbers
    has_secure_password

    :first_name
    :last_name
    :email
    :password_digest
    :uid
    :provider

Barber
    has_many :appointments
    has_many :users, through: :appointments
    has_many :user_favorites, through: :favorite_barbers

    :first_name
    :last_name

Appointment
    belongs_to :user
    belongs_to :barber
    belongs_to :calendar
    has_many :services, through: :services_appointments

    :start_time
    :duration
    :notes_for_barber
    :user_id
    :barber_id

Calendar


Favorite_Barber
    belongs_to :user
    belongs_to :barber

    :user_id
    :barber_id

Service
    has_many :appointments, through: :services_appointments

    :name
    :cost

    Haircut $15
    Beard $15
    Haircut and Beard $25
    hair dye $25

Services_Appointment
    belongs_to :service
    belongs_to :appointment

    :service_id
    :appointment_id 



form_for :appoitment

appointment select 

barber

submit 


Appointment barber, user, time 

