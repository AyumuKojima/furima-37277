FactoryBot.define do
  factory :order_address do
    postal_code   {"111-2222"}
    prefecture_id {2}
    city          {"A市"}
    house_number  {"B番地"}
    building_name {"Cマンション"}
    phone_number  {"11122223333"}
    token         {"tok_abcdefghijk00000000000000000"}
  end
end
