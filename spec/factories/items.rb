FactoryBot.define do
  factory :item do
    item_name     {"Itemアイテムしょうひん商品"}
    info          {"Infoインフォせつめい説明"}
    price         {50000}
    category_id   {2}
    condition_id  {2}
    delivery_id   {2}
    prefecture_id {2}
    send_day_id   {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
