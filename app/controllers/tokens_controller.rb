class TokensController < ApplicationController
    # テスト用 外部から呼べるようにする
    protect_from_forgery except: [:create, :destory]

    # one_time_token を作成
    def create
        token = Digest::SHA1.hexdigest([Time.now, rand].join)
        oen_time_token = OneTimeToken.new({
            mail_address: params['mail_address'],
            type: params['type'],
            token: token
        })
        if oen_time_token.save
            render json: {'message': 'Success'}, status: 200 and return
        else
            render json: {'message': 'Failed to save one_time_token'}, status: 400 and return
        end
    end

    # one_time_token を削除
    def destroy
        one_time_token = find_by_token(params['token'])
        if one_time_token.destroy
            render json: {'message': 'Success'}, status: 200 and return
        else
            render json: {'message': 'Failed to save one_time_token'}, status: 400 and return
        end
    end

    private
    def find_by_token(token)
        OneTimeToken.find_by({token: token})
    end
end
