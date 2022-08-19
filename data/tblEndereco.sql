USE [DBCadastro]
GO

/****** Object:  Table [dbo].[tblEndereco]    Script Date: 19/08/2022 08:32:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblEndereco](
	[CodCadastro] [int] NOT NULL,
	[Cep] [nchar](8) NOT NULL,
	[Endereco] [nvarchar](50) NOT NULL,
	[Cidade] [nvarchar](40) NOT NULL,
	[Uf] [nchar](2) NOT NULL,
	[Num] [nchar](10) NOT NULL
) ON [PRIMARY]
GO

