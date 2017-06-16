class Student < ApplicationRecord
  belongs_to :Institution
  before_save { email.downcase! }
  before_validation :default_values

  validates :name, presence: true, length: { maximum: 50 }

  #REGEX: Regular Expresion for e-mail format validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #Institution's email validation
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :age, presence: true
  validates :gender, presence: true, inclusion: { in: %w(Masculino Femenino),
    message: "%{value} no es un género válido" }
  validates :icfes_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }, presence: true
  validates :school_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, presence: true
  validates :extra_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, presence: true
  validates :personal_id, presence: true
  validates :personal_id_type, presence: true, inclusion: { in: ["Cedula", "Tarjeta de Identidad"],
    message: "%{value} no es un tipo de documento válido" }
  protected
    def default_values
      self.icfes_score ||= 0
      self.school_score ||= 0
      self.extra_score ||= 0
      self.global_score = (self.icfes_score*0.5) + (self.school_score*0.4) + (self.extra_score*0.1)
    end
end
