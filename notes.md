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

    :first_name
    :last_name

Appointment
    belongs_to :user
    belongs_to :barber
    has_many :services, through: :services_appointments

    :start_time
    :duration
    :user_id
    :barber_id

Favorite_Barber
    belongs_to :user
    belongs_to :barber

    :user_id
    :barber_id

Service
    has_many :appointments, through: :services_appointments

    :name
    :cost

Services_Appointments
    belongs_to :service
    belongs_to :appointment

    :service_id
    :appointment_id 


