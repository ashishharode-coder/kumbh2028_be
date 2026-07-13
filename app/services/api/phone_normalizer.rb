module Api
  class PhoneNormalizer
    def self.normalize(phone)
      digits = phone.to_s.gsub(/\D/, "")

      digits = digits.last(10)

      digits
    end
  end
end