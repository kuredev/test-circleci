require "json"
require 'ddtrace'
require 'datadog/lambda'

Datadog::Lambda.configure_apm do |c|
  # インスツルメンテーションを有効にします
end

# 関数をインスツルメントします
def some_operation()
  Datadog.tracer.trace('some_operation') do |span|
      # ここで何かをします
  end
end

def lambda_handler(event:, context:)
    # Datadog ラッパーを適用します
    Datadog::Lambda::wrap(event, context) do
      # Lambda 関数スパンにカスタムタグを追加します
      # X-Ray トレーシングが有効になっている場合は機能しません
      current_span = Datadog.tracer.active_span
      current_span.set_tag('customer.id', '123456')

      some_operation()

      Datadog.tracer.trace('hello.world') do |span|
        puts "Hello, World!"
      end

      # カスタムメトリクスを送信します
      Datadog::Lambda.metric(
        'coffee_house.order_value', # メトリクス名
        12.45, # メトリクス値
        time: Time.now.utc, # オプション、過去 20 分以内である必要があります
        "product":"latte", # タグ
        "order":"online" # タグ
      )
  end
end
