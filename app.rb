require 'unicorn'
require 'sidekiq'
require 'sinatra/base'
require 'newrelic_rpm'

class FirstApp < Sinatra::Base
	get '/about' do
		'This is the First App'
	end

	include Sidekiq::Worker

	def perform
		sleep 5
		puts "Goodnight"
	end

end

class SecondApp < FirstApp
	get '/about' do
		'This is the Second App'
	end

	include Sidekiq::Worker

	def perform
		sleep 5
		puts "Goodmorning"
	end
end

SecondApp.run!

FirstApp.perform_async	
SecondApp.perform_async