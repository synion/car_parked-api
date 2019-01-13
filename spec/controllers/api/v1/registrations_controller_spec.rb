require "spec_helper"

describe Api::V1::RegistrationsController do
  describe "#sign_up" do
    context "when headers has key authorization application key" do
      context "when email is from selleo" do
        it "returns a new user, and status 200" do
          allow(ENV).to receive(:fetch).and_return("my_application|another_application")

          jsondata = {
            "user" => {
              "full_name" => "Szymon Lach",
              "email" => "smth@selleo.com",
              "gmail_id" => "123"
            }
          }
          request.env["devise.mapping"] = Devise.mappings[:user]
          request.headers["HTTP_AUTHORIZATION"] = "my_application"

          expect { post :create, body: jsondata.to_json }.to change { User.count }.by 1
          expect(response).to have_http_status(:ok)
        end
      end

      context "when email isn't from selleo" do
        it "doesn't create user and return error message with status 400" do
          allow(ENV).to receive(:fetch).and_return("my_application|another_application")

          jsondata = {
            "user" => {
              "full_name" => "Szymon Lach",
              "email" => "smth@another.com",
              "gmail_id" => "123"
            }
          }

          request.env["devise.mapping"] = Devise.mappings[:user]
          request.headers["HTTP_AUTHORIZATION"] = "my_application"

          expect { post :create, body: jsondata.to_json }.to_not change { User.count }
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context "when headers has not key authorization application key" do
      it "returns status 401" do
        allow(ENV).to receive(:fetch).and_return("my_application|another_application")

        jsondata = {
          "user" => {
            "full_name" => "Szymon Lach",
            "email" => "smth@another.com",
            "gmail_id" => "123"
          }
        }

        request.env["devise.mapping"] = Devise.mappings[:user]
        request.headers["HTTP_AUTHORIZATION"] = "some_application"

        expect { post :create, body: jsondata.to_json }.to_not change { User.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
