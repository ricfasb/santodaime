class Tuition < ApplicationRecord
  has_one :email

  validates_presence_of :description

  validates :day, presence: true
  validate :min_amount
  validate :send_mail

  def send_mail
      if send_email && self.day_email.blank?
        errors.add('Enviar email ativado: ', 'Informe o dia de envio!')
      end
      if send_email && self.message.blank?
        errors.add('Enviar email ativado: ', 'Necessário preencher a mensagem!')
      end
  end

  #valor minumo da mensalidade
  def min_amount
    if amount.nil? || amount < 5
      errors.add(:amount, 'Insira um valor maior que 5')
    end
  end

end
