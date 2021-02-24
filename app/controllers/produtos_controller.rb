class ProdutosController < ApplicationController

    before_action :set_produto, only: [:edit, :update, :destroy]
    before_action :set_departamento, only: [:edit, :new]
    
    def index

        @produtos = Produto.order(nome: :asc)
        @produto_com_desconto = Produto.order(:preco).limit 1
    
    end

    def new
        @produto = Produto.new
        set_departamento
    end

    def create 
        @produto = Produto.new produto_params
        set_departamento

        if @produto.save
            flash[:notice] = "Produto salvo com sucesso!"
            return redirect_to root_path
        else
            render :new
        end
    end

    def destroy 
        @produto.destroy
        redirect_to root_path
    end

    def busca
        @nome = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@nome}%"
    end

    def edit
        set_departamento
        render :edit
    end

    def update
        if @produto.update produto_params
            flash[:notice] ="Produto atualizado com sucesso!"
            redirect_to root_path
        else
            render :edit
        end
    end
end
    private

    def produto_params
        params.require(:produto).permit(:nome, 
                                        :descricao, 
                                        :preco, 
                                        :quantidade, 
                                        :departamento_id)
    end

    def set_produto
        @produto = Produto.find(params[:id])
    end
    def set_departamento
        @departamento = Departamento.all
    end

    def render (view)
        set_departamento
        render view
    end

