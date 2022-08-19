USE [DBCadastro]
GO

/****** Object:  Table [dbo].[tblCadastro]    Script Date: 19/08/2022 08:31:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCadastro](
	[IdCadastro] [int] NOT NULL,
	[Nome] [nvarchar](80) NOT NULL,
	[Cpf] [nvarchar](11) NOT NULL,
	[NomeMae] [nvarchar](80) NOT NULL,
	[NomePai] [nvarchar](80) NOT NULL,
	[Rg] [nvarchar](14) NOT NULL,
 CONSTRAINT [PK_Cadastro] PRIMARY KEY CLUSTERED 
(
	[IdCadastro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

