USE [UsageDataAnalysis]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[AssociatedGuid] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users] ON [dbo].[Users] 
(
	[AssociatedGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[ClientSessionId] [bigint] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[UserId] [int] NOT NULL,
	[AppVersionMajor] [int] NULL,
	[AppVersionMinor] [int] NULL,
	[AppVersionBuild] [int] NULL,
	[AppVersionRevision] [int] NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idxOptimizerRecommended_Sessions] ON [dbo].[Sessions] 
(
	[UserId] ASC,
	[ClientSessionId] ASC
)
INCLUDE ( [StartTime]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeatureUse]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeatureUse](
	[FeatureUseId] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[UseTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[FeatureId] [int] NOT NULL,
	[ActivationMethodId] [int] NOT NULL,
 CONSTRAINT [PK_FeatureUse] PRIMARY KEY CLUSTERED 
(
	[FeatureUseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FeatureUse] ON [dbo].[FeatureUse] 
(
	[SessionId] ASC,
	[ActivationMethodId] ASC,
	[FeatureId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[FeatureId] [int] IDENTITY(1,1) NOT NULL,
	[FeatureName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[FeatureId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Features] ON [dbo].[Features] 
(
	[FeatureName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exceptions]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exceptions](
	[ExceptionId] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[ExceptionGroupId] [int] NOT NULL,
	[ThrownAt] [datetime] NOT NULL,
	[Stacktrace] [nvarchar](max) NOT NULL,
	[IsFirstInSession] [bit] NOT NULL,
 CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED 
(
	[ExceptionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Exceptions] ON [dbo].[Exceptions] 
(
	[ExceptionGroupId] ASC,
	[IsFirstInSession] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExceptionGroups]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExceptionGroups](
	[ExceptionGroupId] [int] IDENTITY(1,1) NOT NULL,
	[TypeFingerprintSha256Hash] [nvarchar](128) NOT NULL,
	[ExceptionType] [nvarchar](255) NOT NULL,
	[ExceptionFingerprint] [nvarchar](max) NOT NULL,
	[ExceptionLocation] [nvarchar](max) NOT NULL,
	[UserComment] [nvarchar](max) NULL,
	[UserFixedInRevision] [int] NULL,
 CONSTRAINT [PK_ExceptionTypes] PRIMARY KEY CLUSTERED 
(
	[ExceptionGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ExceptionTypes] ON [dbo].[ExceptionGroups] 
(
	[TypeFingerprintSha256Hash] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnvironmentDataValues]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnvironmentDataValues](
	[EnvironmentDataValueId] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentDataValue] [nvarchar](255) NULL,
 CONSTRAINT [PK_EnvironmentDataValues] PRIMARY KEY CLUSTERED 
(
	[EnvironmentDataValueId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_EnvironmentDataValues] ON [dbo].[EnvironmentDataValues] 
(
	[EnvironmentDataValue] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnvironmentDataNames]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnvironmentDataNames](
	[EnvironmentDataNameId] [int] IDENTITY(1,1) NOT NULL,
	[EnvironmentDataName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_EnvironmentDataNames] PRIMARY KEY CLUSTERED 
(
	[EnvironmentDataNameId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_EnvironmentDataNames] ON [dbo].[EnvironmentDataNames] 
(
	[EnvironmentDataName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnvironmentData]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnvironmentData](
	[EnvironmentDataId] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[EnvironmentDataNameId] [int] NOT NULL,
	[EnvironmentDataValueId] [int] NOT NULL,
 CONSTRAINT [PK_EnvironmentData] PRIMARY KEY CLUSTERED 
(
	[EnvironmentDataId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EnvironmentData] ON [dbo].[EnvironmentData] 
(
	[EnvironmentDataNameId] ASC,
	[EnvironmentDataValueId] ASC,
	[SessionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivationMethods]    Script Date: 04/28/2010 18:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivationMethods](
	[ActivationMethodId] [int] IDENTITY(1,1) NOT NULL,
	[ActivationMethodName] [nvarchar](255) NULL,
 CONSTRAINT [PK_ActivationMethods] PRIMARY KEY CLUSTERED 
(
	[ActivationMethodId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ActivationMethods] ON [dbo].[ActivationMethods] 
(
	[ActivationMethodName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


CREATE PROCEDURE [dbo].[DailyUsers]
	-- Add the parameters for the stored procedure here
	@startDate datetime2, 
	@endDate datetime2
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DATEADD(day, DATEDIFF(day,0,StartTime), 0) AS Day, COUNT(DISTINCT UserId) 
                      AS UserCount
		FROM     dbo.Sessions 
		WHERE StartTime BETWEEN @startDate AND @endDate
		GROUP BY DATEADD(day, DATEDIFF(day,0,StartTime), 0)
		ORDER BY Day;

END
GO

CREATE PROCEDURE [dbo].[EnvironmentByWeek]
	@envDataNameId int,
	@startDate datetime2, 
	@endDate datetime2
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		( SELECT EnvironmentDataValues.EnvironmentDataValue
		  FROM EnvironmentDataValues
		  WHERE EnvironmentDataValues.EnvironmentDataValueId = i.EnvironmentDataValueId
		 ) AS Value,
		 Week,
		 c
	FROM (
		SELECT DATEADD(week, DATEDIFF(week,0,Day), 0) AS Week, data.EnvironmentDataValueId, COUNT(*) AS c
		FROM (
			-- take 1 session from each user and day
			SELECT MIN(SessionId) AS SessionId, UserId, DATEADD(day, DATEDIFF(day, 0, StartTime), 0) AS Day
			FROM         dbo.Sessions
			WHERE StartTime BETWEEN @startDate AND @endDate
			GROUP BY UserId, DATEADD(day, DATEDIFF(day, 0, StartTime), 0)
		) AS session
		LEFT JOIN (
			-- join with the environment data for the requested ID
			SELECT EnvironmentDataValueId,SessionId FROM EnvironmentData WHERE EnvironmentDataNameId = @envDataNameId
		) AS data ON data.SessionId = session.SessionId
		-- group into weeks
		GROUP BY DATEADD(week, DATEDIFF(week,0,Day), 0), data.EnvironmentDataValueId
	) AS i
	ORDER BY Value, Week;
END

GO