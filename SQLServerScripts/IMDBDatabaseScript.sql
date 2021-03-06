USE [IMdbDataBase]
GO
/****** Object:  Schema [Logs]    Script Date: 9. 3. 2021. 16:33:50 ******/
CREATE SCHEMA [Logs]
GO
/****** Object:  Schema [Mappings]    Script Date: 9. 3. 2021. 16:33:50 ******/
CREATE SCHEMA [Mappings]
GO
/****** Object:  Schema [stage]    Script Date: 9. 3. 2021. 16:33:50 ******/
CREATE SCHEMA [stage]
GO
/****** Object:  Table [dbo].[RatedMovies]    Script Date: 9. 3. 2021. 16:33:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RatedMovies](
	[tconst] [nvarchar](max) NULL,
	[titleType] [nvarchar](max) NULL,
	[primaryTitle] [nvarchar](max) NULL,
	[originalTitle] [nvarchar](max) NULL,
	[isAdult] [nvarchar](max) NULL,
	[startYear] [nvarchar](max) NULL,
	[endYear] [nvarchar](max) NULL,
	[runtimeMinutes] [nvarchar](max) NULL,
	[genres] [nvarchar](max) NOT NULL,
	[averageRating] [nvarchar](max) NULL,
	[originalGenres] [nvarchar](max) NULL,
	[webLocation] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Logs].[pipeline_errors]    Script Date: 9. 3. 2021. 16:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logs].[pipeline_errors](
	[error_id] [int] IDENTITY(1,1) NOT NULL,
	[DataFactory_Name] [nvarchar](500) NULL,
	[Pipeline_Name] [nvarchar](500) NULL,
	[SourceFile] [nvarchar](500) NULL,
	[DestinationFile] [nvarchar](500) NULL,
	[TriggerType] [nvarchar](500) NULL,
	[TriggerId] [nvarchar](500) NULL,
	[TriggerName] [nvarchar](500) NULL,
	[TriggerTime] [nvarchar](500) NULL,
	[Execution_Status] [nvarchar](500) NULL,
	[ErrorDescription] [nvarchar](max) NULL,
	[ErrorCode] [nvarchar](500) NULL,
	[ErrorLoggedTime] [nvarchar](500) NULL,
	[FailureType] [nvarchar](500) NULL,
 CONSTRAINT [PK_pipeline_error] PRIMARY KEY CLUSTERED 
(
	[error_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Logs].[pipeline_log]    Script Date: 9. 3. 2021. 16:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logs].[pipeline_log](
	[LOG_ID] [int] IDENTITY(1,1) NOT NULL,
	[DataFactory_Name] [nvarchar](500) NULL,
	[Pipeline_Name] [nvarchar](500) NULL,
	[SourceFile] [nvarchar](500) NULL,
	[DestinationFile] [nvarchar](500) NULL,
	[Execution_Status] [nvarchar](500) NULL,
	[TriggerType] [nvarchar](500) NULL,
	[TriggerId] [nvarchar](500) NULL,
	[TriggerName] [nvarchar](500) NULL,
	[TriggerTime] [nvarchar](500) NULL,
 CONSTRAINT [PK_pipeline_log] PRIMARY KEY CLUSTERED 
(
	[LOG_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Mappings].[LoadFilesMappings]    Script Date: 9. 3. 2021. 16:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Mappings].[LoadFilesMappings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PipelineId] [int] NULL,
	[SourceContainer] [nvarchar](255) NULL,
	[SourceFolder] [nvarchar](255) NULL,
	[SourceFileName] [nvarchar](255) NULL,
	[SourceFileFormat] [nvarchar](255) NULL,
	[SourceSchema] [nvarchar](50) NULL,
	[SourceSQLTable] [nvarchar](100) NULL,
	[DestinationContainer] [varchar](50) NULL,
	[DestinationFolder] [varchar](50) NULL,
	[DestinationFileName] [nvarchar](255) NULL,
	[DestinationFileFormat] [nvarchar](255) NULL,
	[DestinationSchema] [varchar](50) NULL,
	[DestinationSQLTable] [varchar](50) NULL,
	[IsActive] [int] NULL,
 CONSTRAINT [PK_LoadFilesMappings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stage].[Akas]    Script Date: 9. 3. 2021. 16:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Akas](
	[titleId] [nvarchar](max) NULL,
	[ordering] [nvarchar](max) NULL,
	[title] [nvarchar](max) NULL,
	[region] [nvarchar](max) NULL,
	[language] [nvarchar](max) NULL,
	[types] [nvarchar](max) NULL,
	[attributes] [nvarchar](max) NULL,
	[isOriginalTitle] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stage].[Crew]    Script Date: 9. 3. 2021. 16:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Crew](
	[tconst] [nvarchar](max) NULL,
	[directors] [nvarchar](max) NULL,
	[writers] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stage].[Episode]    Script Date: 9. 3. 2021. 16:33:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Episode](
	[tconst] [nvarchar](max) NULL,
	[parentTconst] [nvarchar](max) NULL,
	[seasonNumber] [nvarchar](max) NULL,
	[episodeNumber] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stage].[movies]    Script Date: 9. 3. 2021. 16:33:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[movies](
	[tconst] [nvarchar](max) NULL,
	[titleType] [nvarchar](max) NULL,
	[primaryTitle] [nvarchar](max) NULL,
	[originalTitle] [nvarchar](max) NULL,
	[isAdult] [nvarchar](max) NULL,
	[startYear] [nvarchar](max) NULL,
	[endYear] [nvarchar](max) NULL,
	[runtimeMinutes] [nvarchar](max) NULL,
	[genres] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stage].[Principals]    Script Date: 9. 3. 2021. 16:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Principals](
	[tconst] [nvarchar](max) NULL,
	[ordering] [nvarchar](max) NULL,
	[nconst] [nvarchar](max) NULL,
	[category] [nvarchar](max) NULL,
	[job] [nvarchar](max) NULL,
	[characters] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stage].[Ratings]    Script Date: 9. 3. 2021. 16:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Ratings](
	[tconst] [nvarchar](max) NULL,
	[averageRating] [nvarchar](max) NULL,
	[numVotes] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Logs].[sp_UpdateErrorTable]    Script Date: 9. 3. 2021. 16:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [Logs].[sp_UpdateErrorTable]
   @DataFactory_Name [nvarchar](500) NULL,
   @Pipeline_Name [nvarchar](500) NULL,
   @SourceFile [nvarchar](500) NULL,
   @DestinationFile [nvarchar](500) NULL,
   @TriggerType [nvarchar](500) NULL,
   @TriggerId [nvarchar](500) NULL,
   @TriggerName [nvarchar](500) NULL,
   @TriggerTime [nvarchar](500) NULL,
   @Execution_Status [nvarchar](500) NULL,
   @ErrorDescription [nvarchar](max) NULL,
   @ErrorCode [nvarchar](500) NULL,
   @ErrorLoggedTime [nvarchar](500) NULL,
   @FailureType [nvarchar](500) NULL
AS
INSERT INTO Logs.[pipeline_errors]
 
(
   [DataFactory_Name],
   [Pipeline_Name],
   [SourceFile],
   [DestinationFile],
   [TriggerType],
   [TriggerId],
   [TriggerName],
   [TriggerTime],
   [Execution_Status],
   [ErrorDescription],
   [ErrorCode],
   [ErrorLoggedTime],
   [FailureType]
)
VALUES
(
   @DataFactory_Name,
   @Pipeline_Name,
   @SourceFile,
   @DestinationFile,
   @TriggerType,
   @TriggerId,
   @TriggerName,
   @TriggerTime,
   @Execution_Status,
   @ErrorDescription,
   @ErrorCode,
   @ErrorLoggedTime,
   @FailureType
)
GO
/****** Object:  StoredProcedure [Logs].[sp_UpdateLogTable]    Script Date: 9. 3. 2021. 16:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [Logs].[sp_UpdateLogTable]
@DataFactory_Name VARCHAR(250),
@Pipeline_Name VARCHAR(250),
@SourceFile VARCHAR(250),
@DestinationFile VARCHAR(300),
@Execution_Status VARCHAR(300),
@TriggerType [nvarchar](500) NULL,
@TriggerId [nvarchar](500) NULL,
@TriggerName [nvarchar](500) NULL,
@TriggerTime [nvarchar](500) NULL
AS
INSERT INTO Logs.[pipeline_log]
(
      [DataFactory_Name]
      ,[Pipeline_Name]
      ,[SourceFile]
      ,[DestinationFile]
      ,Execution_Status
	  ,TriggerType
	  ,TriggerId
	  ,TriggerName
	  ,TriggerTime

)
VALUES
(
	 @DataFactory_Name
	,@Pipeline_Name 
	,@SourceFile 
	,@DestinationFile
	,@Execution_Status
	,@TriggerType
	,@TriggerId 
	,@TriggerName 
	,@TriggerTime
)
GO
