class Produto < ApplicationRecord

    belongs_to :departamento, optional: true

    validates :departamento_id, presence: true
    validates :preco, presence: true
    validates :nome, length: {minimum: 4}
    validates :quantidade, presence: true
end
