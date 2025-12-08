-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateEnum
CREATE TYPE "public"."SchedulingType" AS ENUM ('roundRobin', 'collective', 'managed');

-- CreateEnum
CREATE TYPE "public"."PeriodType" AS ENUM ('unlimited', 'rolling', 'rolling_window', 'range');

-- CreateEnum
CREATE TYPE "public"."CreationSource" AS ENUM ('api_v1', 'api_v2', 'webapp');

-- CreateEnum
CREATE TYPE "public"."IdentityProvider" AS ENUM ('CAL', 'GOOGLE', 'SAML');

-- CreateEnum
CREATE TYPE "public"."UserPermissionRole" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "public"."CreditUsageType" AS ENUM ('SMS', 'CAL_AI_PHONE_CALL');

-- CreateEnum
CREATE TYPE "public"."CreditType" AS ENUM ('MONTHLY', 'ADDITIONAL');

-- CreateEnum
CREATE TYPE "public"."MembershipRole" AS ENUM ('MEMBER', 'ADMIN', 'OWNER');

-- CreateEnum
CREATE TYPE "public"."BookingStatus" AS ENUM ('cancelled', 'accepted', 'rejected', 'pending', 'awaiting_host');

-- CreateEnum
CREATE TYPE "public"."EventTypeCustomInputType" AS ENUM ('text', 'textLong', 'number', 'bool', 'radio', 'phone');

-- CreateEnum
CREATE TYPE "public"."ReminderType" AS ENUM ('PENDING_BOOKING_CONFIRMATION');

-- CreateEnum
CREATE TYPE "public"."PaymentOption" AS ENUM ('ON_BOOKING', 'HOLD');

-- CreateEnum
CREATE TYPE "public"."WebhookTriggerEvents" AS ENUM ('BOOKING_CREATED', 'BOOKING_PAYMENT_INITIATED', 'BOOKING_PAID', 'BOOKING_RESCHEDULED', 'BOOKING_REQUESTED', 'BOOKING_CANCELLED', 'BOOKING_REJECTED', 'BOOKING_NO_SHOW_UPDATED', 'FORM_SUBMITTED', 'MEETING_ENDED', 'MEETING_STARTED', 'RECORDING_READY', 'INSTANT_MEETING', 'RECORDING_TRANSCRIPTION_GENERATED', 'OOO_CREATED', 'AFTER_HOSTS_CAL_VIDEO_NO_SHOW', 'AFTER_GUESTS_CAL_VIDEO_NO_SHOW', 'FORM_SUBMITTED_NO_EVENT', 'DELEGATION_CREDENTIAL_ERROR');

-- CreateEnum
CREATE TYPE "public"."AppCategories" AS ENUM ('calendar', 'messaging', 'other', 'payment', 'video', 'web3', 'automation', 'analytics', 'conferencing', 'crm');

-- CreateEnum
CREATE TYPE "public"."WorkflowTriggerEvents" AS ENUM ('BEFORE_EVENT', 'EVENT_CANCELLED', 'NEW_EVENT', 'AFTER_EVENT', 'RESCHEDULE_EVENT', 'AFTER_HOSTS_CAL_VIDEO_NO_SHOW', 'AFTER_GUESTS_CAL_VIDEO_NO_SHOW', 'FORM_SUBMITTED', 'FORM_SUBMITTED_NO_EVENT', 'BOOKING_REJECTED', 'BOOKING_REQUESTED', 'BOOKING_PAYMENT_INITIATED', 'BOOKING_PAID', 'BOOKING_NO_SHOW_UPDATED');

-- CreateEnum
CREATE TYPE "public"."WorkflowActions" AS ENUM ('EMAIL_HOST', 'EMAIL_ATTENDEE', 'SMS_ATTENDEE', 'SMS_NUMBER', 'EMAIL_ADDRESS', 'WHATSAPP_ATTENDEE', 'WHATSAPP_NUMBER', 'CAL_AI_PHONE_CALL');

-- CreateEnum
CREATE TYPE "public"."WorkflowType" AS ENUM ('EVENT_TYPE', 'ROUTING_FORM');

-- CreateEnum
CREATE TYPE "public"."TimeUnit" AS ENUM ('day', 'hour', 'minute');

-- CreateEnum
CREATE TYPE "public"."WorkflowTemplates" AS ENUM ('REMINDER', 'CUSTOM', 'CANCELLED', 'RESCHEDULED', 'COMPLETED', 'RATING');

-- CreateEnum
CREATE TYPE "public"."WorkflowMethods" AS ENUM ('EMAIL', 'SMS', 'WHATSAPP', 'AI_PHONE_CALL');

-- CreateEnum
CREATE TYPE "public"."FeatureType" AS ENUM ('RELEASE', 'EXPERIMENT', 'OPERATIONAL', 'KILL_SWITCH', 'PERMISSION');

-- CreateEnum
CREATE TYPE "public"."RRResetInterval" AS ENUM ('MONTH', 'DAY');

-- CreateEnum
CREATE TYPE "public"."RRTimestampBasis" AS ENUM ('CREATED_AT', 'START_TIME');

-- CreateEnum
CREATE TYPE "public"."AccessScope" AS ENUM ('READ_BOOKING', 'READ_PROFILE');

-- CreateEnum
CREATE TYPE "public"."RedirectType" AS ENUM ('user-event-type', 'team-event-type', 'user', 'team');

-- CreateEnum
CREATE TYPE "public"."SMSLockState" AS ENUM ('LOCKED', 'UNLOCKED', 'REVIEW_NEEDED');

-- CreateEnum
CREATE TYPE "public"."AttributeType" AS ENUM ('TEXT', 'NUMBER', 'SINGLE_SELECT', 'MULTI_SELECT');

-- CreateEnum
CREATE TYPE "public"."AssignmentReasonEnum" AS ENUM ('ROUTING_FORM_ROUTING', 'ROUTING_FORM_ROUTING_FALLBACK', 'REASSIGNED', 'RR_REASSIGNED', 'REROUTED', 'SALESFORCE_ASSIGNMENT');

-- CreateEnum
CREATE TYPE "public"."EventTypeAutoTranslatedField" AS ENUM ('DESCRIPTION', 'TITLE');

-- CreateEnum
CREATE TYPE "public"."WatchlistType" AS ENUM ('EMAIL', 'DOMAIN', 'USERNAME');

-- CreateEnum
CREATE TYPE "public"."WatchlistAction" AS ENUM ('REPORT', 'BLOCK', 'ALERT');

-- CreateEnum
CREATE TYPE "public"."WatchlistSource" AS ENUM ('MANUAL', 'FREE_DOMAIN_POLICY');

-- CreateEnum
CREATE TYPE "public"."BookingReportReason" AS ENUM ('SPAM', 'dont_know_person', 'OTHER');

-- CreateEnum
CREATE TYPE "public"."BookingReportStatus" AS ENUM ('PENDING', 'DISMISSED', 'BLOCKED');

-- CreateEnum
CREATE TYPE "public"."BillingPeriod" AS ENUM ('MONTHLY', 'ANNUALLY');

-- CreateEnum
CREATE TYPE "public"."IncompleteBookingActionType" AS ENUM ('SALESFORCE');

-- CreateEnum
CREATE TYPE "public"."FilterSegmentScope" AS ENUM ('USER', 'TEAM');

-- CreateEnum
CREATE TYPE "public"."WorkflowContactType" AS ENUM ('PHONE', 'EMAIL');

-- CreateEnum
CREATE TYPE "public"."RoleType" AS ENUM ('SYSTEM', 'CUSTOM');

-- CreateEnum
CREATE TYPE "public"."PhoneNumberSubscriptionStatus" AS ENUM ('ACTIVE', 'PAST_DUE', 'CANCELLED', 'INCOMPLETE', 'INCOMPLETE_EXPIRED', 'TRIALING', 'UNPAID');

-- CreateEnum
CREATE TYPE "public"."CalendarCacheEventStatus" AS ENUM ('confirmed', 'tentative', 'cancelled');

-- CreateTable
CREATE TABLE "public"."Host" (
    "userId" INTEGER NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "isFixed" BOOLEAN NOT NULL DEFAULT false,
    "priority" INTEGER,
    "weight" INTEGER,
    "weightAdjustment" INTEGER,
    "scheduleId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "groupId" TEXT,
    "memberId" INTEGER,

    CONSTRAINT "Host_pkey" PRIMARY KEY ("userId","eventTypeId")
);

-- CreateTable
CREATE TABLE "public"."HostGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "eventTypeId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HostGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CalVideoSettings" (
    "eventTypeId" INTEGER NOT NULL,
    "disableRecordingForOrganizer" BOOLEAN NOT NULL DEFAULT false,
    "disableRecordingForGuests" BOOLEAN NOT NULL DEFAULT false,
    "enableAutomaticTranscription" BOOLEAN NOT NULL DEFAULT false,
    "enableAutomaticRecordingForOrganizer" BOOLEAN NOT NULL DEFAULT false,
    "redirectUrlOnExit" TEXT,
    "disableTranscriptionForGuests" BOOLEAN NOT NULL DEFAULT false,
    "disableTranscriptionForOrganizer" BOOLEAN NOT NULL DEFAULT false,
    "requireEmailForGuests" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CalVideoSettings_pkey" PRIMARY KEY ("eventTypeId")
);

-- CreateTable
CREATE TABLE "public"."VideoCallGuest" (
    "id" TEXT NOT NULL,
    "bookingUid" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "joinedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VideoCallGuest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."EventType" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "interfaceLanguage" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "locations" JSONB,
    "length" INTEGER NOT NULL,
    "offsetStart" INTEGER NOT NULL DEFAULT 0,
    "hidden" BOOLEAN NOT NULL DEFAULT false,
    "userId" INTEGER,
    "profileId" INTEGER,
    "teamId" INTEGER,
    "useEventLevelSelectedCalendars" BOOLEAN NOT NULL DEFAULT false,
    "eventName" TEXT,
    "parentId" INTEGER,
    "bookingFields" JSONB,
    "timeZone" TEXT,
    "periodType" "public"."PeriodType" NOT NULL DEFAULT 'unlimited',
    "periodStartDate" TIMESTAMP(3),
    "periodEndDate" TIMESTAMP(3),
    "periodDays" INTEGER,
    "periodCountCalendarDays" BOOLEAN,
    "lockTimeZoneToggleOnBookingPage" BOOLEAN NOT NULL DEFAULT false,
    "lockedTimeZone" TEXT,
    "requiresConfirmation" BOOLEAN NOT NULL DEFAULT false,
    "requiresConfirmationWillBlockSlot" BOOLEAN NOT NULL DEFAULT false,
    "requiresConfirmationForFreeEmail" BOOLEAN NOT NULL DEFAULT false,
    "requiresBookerEmailVerification" BOOLEAN NOT NULL DEFAULT false,
    "canSendCalVideoTranscriptionEmails" BOOLEAN NOT NULL DEFAULT true,
    "autoTranslateDescriptionEnabled" BOOLEAN NOT NULL DEFAULT false,
    "recurringEvent" JSONB,
    "disableGuests" BOOLEAN NOT NULL DEFAULT false,
    "hideCalendarNotes" BOOLEAN NOT NULL DEFAULT false,
    "hideCalendarEventDetails" BOOLEAN NOT NULL DEFAULT false,
    "minimumBookingNotice" INTEGER NOT NULL DEFAULT 120,
    "beforeEventBuffer" INTEGER NOT NULL DEFAULT 0,
    "afterEventBuffer" INTEGER NOT NULL DEFAULT 0,
    "seatsPerTimeSlot" INTEGER,
    "onlyShowFirstAvailableSlot" BOOLEAN NOT NULL DEFAULT false,
    "showOptimizedSlots" BOOLEAN DEFAULT false,
    "disableCancelling" BOOLEAN DEFAULT false,
    "disableRescheduling" BOOLEAN DEFAULT false,
    "seatsShowAttendees" BOOLEAN DEFAULT false,
    "seatsShowAvailabilityCount" BOOLEAN DEFAULT true,
    "schedulingType" "public"."SchedulingType",
    "scheduleId" INTEGER,
    "allowReschedulingCancelledBookings" BOOLEAN DEFAULT false,
    "price" INTEGER NOT NULL DEFAULT 0,
    "currency" TEXT NOT NULL DEFAULT 'usd',
    "slotInterval" INTEGER,
    "metadata" JSONB,
    "successRedirectUrl" TEXT,
    "forwardParamsSuccessRedirect" BOOLEAN DEFAULT true,
    "bookingLimits" JSONB,
    "durationLimits" JSONB,
    "isInstantEvent" BOOLEAN NOT NULL DEFAULT false,
    "instantMeetingExpiryTimeOffsetInSeconds" INTEGER NOT NULL DEFAULT 90,
    "instantMeetingScheduleId" INTEGER,
    "instantMeetingParameters" TEXT[],
    "assignAllTeamMembers" BOOLEAN NOT NULL DEFAULT false,
    "assignRRMembersUsingSegment" BOOLEAN NOT NULL DEFAULT false,
    "rrSegmentQueryValue" JSONB,
    "useEventTypeDestinationCalendarEmail" BOOLEAN NOT NULL DEFAULT false,
    "isRRWeightsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "maxLeadThreshold" INTEGER,
    "includeNoShowInRRCalculation" BOOLEAN NOT NULL DEFAULT false,
    "allowReschedulingPastBookings" BOOLEAN NOT NULL DEFAULT false,
    "hideOrganizerEmail" BOOLEAN NOT NULL DEFAULT false,
    "maxActiveBookingsPerBooker" INTEGER,
    "maxActiveBookingPerBookerOfferReschedule" BOOLEAN NOT NULL DEFAULT false,
    "customReplyToEmail" TEXT,
    "eventTypeColor" JSONB,
    "rescheduleWithSameRoundRobinHost" BOOLEAN NOT NULL DEFAULT false,
    "secondaryEmailId" INTEGER,
    "useBookerTimezone" BOOLEAN NOT NULL DEFAULT false,
    "restrictionScheduleId" INTEGER,
    "bookingRequiresAuthentication" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "EventType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Credential" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "key" JSONB NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "appId" TEXT,
    "subscriptionId" TEXT,
    "paymentStatus" TEXT,
    "billingCycleStart" INTEGER,
    "invalid" BOOLEAN DEFAULT false,
    "delegationCredentialId" TEXT,

    CONSTRAINT "Credential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DestinationCalendar" (
    "id" SERIAL NOT NULL,
    "integration" TEXT NOT NULL,
    "externalId" TEXT NOT NULL,
    "primaryEmail" TEXT,
    "userId" INTEGER,
    "eventTypeId" INTEGER,
    "credentialId" INTEGER,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "delegationCredentialId" TEXT,
    "domainWideDelegationCredentialId" TEXT,

    CONSTRAINT "DestinationCalendar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserPassword" (
    "hash" TEXT NOT NULL,
    "userId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "public"."TravelSchedule" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "timeZone" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "prevTimeZone" TEXT,

    CONSTRAINT "TravelSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."users" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "username" TEXT,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "emailVerified" TIMESTAMP(3),
    "bio" TEXT,
    "avatarUrl" TEXT,
    "timeZone" TEXT NOT NULL DEFAULT 'Europe/London',
    "weekStart" TEXT NOT NULL DEFAULT 'Sunday',
    "startTime" INTEGER NOT NULL DEFAULT 0,
    "endTime" INTEGER NOT NULL DEFAULT 1440,
    "bufferTime" INTEGER NOT NULL DEFAULT 0,
    "hideBranding" BOOLEAN NOT NULL DEFAULT false,
    "theme" TEXT,
    "appTheme" TEXT,
    "created" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "trialEndsAt" TIMESTAMP(3),
    "lastActiveAt" TIMESTAMP(3),
    "defaultScheduleId" INTEGER,
    "completedOnboarding" BOOLEAN NOT NULL DEFAULT false,
    "locale" TEXT,
    "timeFormat" INTEGER DEFAULT 12,
    "twoFactorSecret" TEXT,
    "twoFactorEnabled" BOOLEAN NOT NULL DEFAULT false,
    "backupCodes" TEXT,
    "identityProvider" "public"."IdentityProvider" NOT NULL DEFAULT 'CAL',
    "identityProviderId" TEXT,
    "invitedTo" INTEGER,
    "brandColor" TEXT,
    "darkBrandColor" TEXT,
    "allowDynamicBooking" BOOLEAN DEFAULT true,
    "allowSEOIndexing" BOOLEAN DEFAULT true,
    "receiveMonthlyDigestEmail" BOOLEAN DEFAULT true,
    "requiresBookerEmailVerification" BOOLEAN DEFAULT false,
    "metadata" JSONB,
    "verified" BOOLEAN DEFAULT false,
    "role" "public"."UserPermissionRole" NOT NULL DEFAULT 'USER',
    "disableImpersonation" BOOLEAN NOT NULL DEFAULT false,
    "organizationId" INTEGER,
    "locked" BOOLEAN NOT NULL DEFAULT false,
    "movedToProfileId" INTEGER,
    "isPlatformManaged" BOOLEAN NOT NULL DEFAULT false,
    "smsLockState" "public"."SMSLockState" NOT NULL DEFAULT 'UNLOCKED',
    "smsLockReviewedByAdmin" BOOLEAN NOT NULL DEFAULT false,
    "referralLinkId" TEXT,
    "creationSource" "public"."CreationSource",
    "whitelistWorkflows" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."NotificationsSubscriptions" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "subscription" TEXT NOT NULL,

    CONSTRAINT "NotificationsSubscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Profile" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "organizationId" INTEGER NOT NULL,
    "username" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Team" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT,
    "logoUrl" TEXT,
    "calVideoLogo" TEXT,
    "appLogo" TEXT,
    "appIconLogo" TEXT,
    "bio" TEXT,
    "hideBranding" BOOLEAN NOT NULL DEFAULT false,
    "hideTeamProfileLink" BOOLEAN NOT NULL DEFAULT false,
    "isPrivate" BOOLEAN NOT NULL DEFAULT false,
    "hideBookATeamMember" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metadata" JSONB,
    "theme" TEXT,
    "rrResetInterval" "public"."RRResetInterval" DEFAULT 'MONTH',
    "rrTimestampBasis" "public"."RRTimestampBasis" NOT NULL DEFAULT 'CREATED_AT',
    "brandColor" TEXT,
    "darkBrandColor" TEXT,
    "bannerUrl" TEXT,
    "parentId" INTEGER,
    "timeFormat" INTEGER,
    "timeZone" TEXT NOT NULL DEFAULT 'Europe/London',
    "weekStart" TEXT NOT NULL DEFAULT 'Sunday',
    "isOrganization" BOOLEAN NOT NULL DEFAULT false,
    "pendingPayment" BOOLEAN NOT NULL DEFAULT false,
    "isPlatform" BOOLEAN NOT NULL DEFAULT false,
    "createdByOAuthClientId" TEXT,
    "smsLockState" "public"."SMSLockState" NOT NULL DEFAULT 'UNLOCKED',
    "smsLockReviewedByAdmin" BOOLEAN NOT NULL DEFAULT false,
    "bookingLimits" JSONB,
    "includeManagedEventsInLimits" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CreditBalance" (
    "id" TEXT NOT NULL,
    "teamId" INTEGER,
    "userId" INTEGER,
    "additionalCredits" INTEGER NOT NULL DEFAULT 0,
    "limitReachedAt" TIMESTAMP(3),
    "warningSentAt" TIMESTAMP(3),

    CONSTRAINT "CreditBalance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CreditPurchaseLog" (
    "id" TEXT NOT NULL,
    "creditBalanceId" TEXT NOT NULL,
    "credits" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CreditPurchaseLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CreditExpenseLog" (
    "id" TEXT NOT NULL,
    "creditBalanceId" TEXT NOT NULL,
    "bookingUid" TEXT,
    "credits" INTEGER,
    "creditType" "public"."CreditType" NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "smsSid" TEXT,
    "smsSegments" INTEGER,
    "phoneNumber" TEXT,
    "email" TEXT,
    "callDuration" INTEGER,
    "creditFor" "public"."CreditUsageType",
    "externalRef" TEXT,

    CONSTRAINT "CreditExpenseLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OrganizationSettings" (
    "id" SERIAL NOT NULL,
    "organizationId" INTEGER NOT NULL,
    "isOrganizationConfigured" BOOLEAN NOT NULL DEFAULT false,
    "isOrganizationVerified" BOOLEAN NOT NULL DEFAULT false,
    "orgAutoAcceptEmail" TEXT NOT NULL,
    "lockEventTypeCreationForUsers" BOOLEAN NOT NULL DEFAULT false,
    "adminGetsNoSlotsNotification" BOOLEAN NOT NULL DEFAULT false,
    "isAdminReviewed" BOOLEAN NOT NULL DEFAULT false,
    "isAdminAPIEnabled" BOOLEAN NOT NULL DEFAULT false,
    "allowSEOIndexing" BOOLEAN NOT NULL DEFAULT false,
    "orgProfileRedirectsToVerifiedDomain" BOOLEAN NOT NULL DEFAULT false,
    "disablePhoneOnlySMSNotifications" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "OrganizationSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Membership" (
    "id" SERIAL NOT NULL,
    "teamId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "accepted" BOOLEAN NOT NULL DEFAULT false,
    "role" "public"."MembershipRole" NOT NULL,
    "customRoleId" TEXT,
    "disableImpersonation" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Membership_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."VerificationToken" (
    "id" SERIAL NOT NULL,
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "expiresInDays" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "teamId" INTEGER,
    "secondaryEmailId" INTEGER,

    CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."InstantMeetingToken" (
    "id" SERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "teamId" INTEGER NOT NULL,
    "bookingId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InstantMeetingToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BookingReference" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "uid" TEXT NOT NULL,
    "meetingId" TEXT,
    "thirdPartyRecurringEventId" TEXT,
    "meetingPassword" TEXT,
    "meetingUrl" TEXT,
    "bookingId" INTEGER,
    "externalCalendarId" TEXT,
    "deleted" BOOLEAN,
    "credentialId" INTEGER,
    "delegationCredentialId" TEXT,
    "domainWideDelegationCredentialId" TEXT,

    CONSTRAINT "BookingReference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Attendee" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "timeZone" TEXT NOT NULL,
    "phoneNumber" TEXT,
    "locale" TEXT DEFAULT 'en',
    "bookingId" INTEGER,
    "noShow" BOOLEAN DEFAULT false,

    CONSTRAINT "Attendee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Booking" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "idempotencyKey" TEXT,
    "userId" INTEGER,
    "userPrimaryEmail" TEXT,
    "eventTypeId" INTEGER,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "customInputs" JSONB,
    "responses" JSONB,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "location" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "status" "public"."BookingStatus" NOT NULL DEFAULT 'accepted',
    "paid" BOOLEAN NOT NULL DEFAULT false,
    "destinationCalendarId" INTEGER,
    "cancellationReason" TEXT,
    "rejectionReason" TEXT,
    "reassignReason" TEXT,
    "reassignById" INTEGER,
    "dynamicEventSlugRef" TEXT,
    "dynamicGroupSlugRef" TEXT,
    "rescheduled" BOOLEAN,
    "fromReschedule" TEXT,
    "recurringEventId" TEXT,
    "smsReminderNumber" TEXT,
    "scheduledJobs" TEXT[],
    "metadata" JSONB,
    "isRecorded" BOOLEAN NOT NULL DEFAULT false,
    "iCalUID" TEXT DEFAULT '',
    "iCalSequence" INTEGER NOT NULL DEFAULT 0,
    "rating" INTEGER,
    "ratingFeedback" TEXT,
    "noShowHost" BOOLEAN DEFAULT false,
    "oneTimePassword" TEXT,
    "cancelledBy" TEXT,
    "rescheduledBy" TEXT,
    "creationSource" "public"."CreationSource",

    CONSTRAINT "Booking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Tracking" (
    "id" SERIAL NOT NULL,
    "bookingId" INTEGER NOT NULL,
    "utm_source" TEXT,
    "utm_medium" TEXT,
    "utm_campaign" TEXT,
    "utm_term" TEXT,
    "utm_content" TEXT,

    CONSTRAINT "Tracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Schedule" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "timeZone" TEXT,

    CONSTRAINT "Schedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Availability" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "eventTypeId" INTEGER,
    "days" INTEGER[],
    "startTime" TIME NOT NULL,
    "endTime" TIME NOT NULL,
    "date" DATE,
    "scheduleId" INTEGER,

    CONSTRAINT "Availability_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SelectedCalendar" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "integration" TEXT NOT NULL,
    "externalId" TEXT NOT NULL,
    "credentialId" INTEGER,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "googleChannelId" TEXT,
    "googleChannelKind" TEXT,
    "googleChannelResourceId" TEXT,
    "googleChannelResourceUri" TEXT,
    "googleChannelExpiration" TEXT,
    "channelId" TEXT,
    "channelKind" TEXT,
    "channelResourceId" TEXT,
    "channelResourceUri" TEXT,
    "channelExpiration" TIMESTAMP(3),
    "syncSubscribedAt" TIMESTAMP(3),
    "syncToken" TEXT,
    "syncedAt" TIMESTAMP(3),
    "syncErrorAt" TIMESTAMP(3),
    "syncErrorCount" INTEGER DEFAULT 0,
    "delegationCredentialId" TEXT,
    "domainWideDelegationCredentialId" TEXT,
    "error" TEXT,
    "lastErrorAt" TIMESTAMP(3),
    "watchAttempts" INTEGER NOT NULL DEFAULT 0,
    "unwatchAttempts" INTEGER NOT NULL DEFAULT 0,
    "maxAttempts" INTEGER NOT NULL DEFAULT 3,
    "eventTypeId" INTEGER,

    CONSTRAINT "SelectedCalendar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."EventTypeCustomInput" (
    "id" SERIAL NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "label" TEXT NOT NULL,
    "type" "public"."EventTypeCustomInputType" NOT NULL,
    "options" JSONB,
    "required" BOOLEAN NOT NULL,
    "placeholder" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "EventTypeCustomInput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ResetPasswordRequest" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ResetPasswordRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ReminderMail" (
    "id" SERIAL NOT NULL,
    "referenceId" INTEGER NOT NULL,
    "reminderType" "public"."ReminderType" NOT NULL,
    "elapsedMinutes" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ReminderMail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Payment" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "appId" TEXT,
    "bookingId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "fee" INTEGER NOT NULL,
    "currency" TEXT NOT NULL,
    "success" BOOLEAN NOT NULL,
    "refunded" BOOLEAN NOT NULL,
    "data" JSONB NOT NULL,
    "externalId" TEXT NOT NULL,
    "paymentOption" "public"."PaymentOption" DEFAULT 'ON_BOOKING',

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Webhook" (
    "id" TEXT NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "eventTypeId" INTEGER,
    "platformOAuthClientId" TEXT,
    "subscriberUrl" TEXT NOT NULL,
    "payloadTemplate" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "eventTriggers" "public"."WebhookTriggerEvents"[],
    "appId" TEXT,
    "secret" TEXT,
    "platform" BOOLEAN NOT NULL DEFAULT false,
    "time" INTEGER,
    "timeUnit" "public"."TimeUnit",

    CONSTRAINT "Webhook_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Impersonations" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "impersonatedUserId" INTEGER NOT NULL,
    "impersonatedById" INTEGER NOT NULL,

    CONSTRAINT "Impersonations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ApiKey" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "teamId" INTEGER,
    "note" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "lastUsedAt" TIMESTAMP(3),
    "hashedKey" TEXT NOT NULL,
    "appId" TEXT,

    CONSTRAINT "ApiKey_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."RateLimit" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "apiKeyId" TEXT NOT NULL,
    "ttl" INTEGER NOT NULL,
    "limit" INTEGER NOT NULL,
    "blockDuration" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RateLimit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."HashedLink" (
    "id" SERIAL NOT NULL,
    "link" TEXT NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "maxUsageCount" INTEGER NOT NULL DEFAULT 1,
    "usageCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "HashedLink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Account" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "providerEmail" TEXT,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."App" (
    "slug" TEXT NOT NULL,
    "dirName" TEXT NOT NULL,
    "keys" JSONB,
    "categories" "public"."AppCategories"[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "App_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "public"."App_RoutingForms_Form" (
    "id" TEXT NOT NULL,
    "description" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "routes" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "fields" JSONB,
    "updatedById" INTEGER,
    "userId" INTEGER NOT NULL,
    "teamId" INTEGER,
    "disabled" BOOLEAN NOT NULL DEFAULT false,
    "settings" JSONB,

    CONSTRAINT "App_RoutingForms_Form_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."App_RoutingForms_FormResponse" (
    "id" SERIAL NOT NULL,
    "uuid" TEXT,
    "formFillerId" TEXT NOT NULL,
    "formId" TEXT NOT NULL,
    "response" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "routedToBookingUid" TEXT,
    "chosenRouteId" TEXT,

    CONSTRAINT "App_RoutingForms_FormResponse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."App_RoutingForms_QueuedFormResponse" (
    "id" TEXT NOT NULL,
    "formId" TEXT NOT NULL,
    "response" JSONB NOT NULL,
    "chosenRouteId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "actualResponseId" INTEGER,

    CONSTRAINT "App_RoutingForms_QueuedFormResponse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."RoutingFormResponseField" (
    "id" SERIAL NOT NULL,
    "responseId" INTEGER NOT NULL,
    "fieldId" TEXT NOT NULL,
    "valueString" TEXT,
    "valueNumber" DECIMAL(65,30),
    "valueStringArray" TEXT[],

    CONSTRAINT "RoutingFormResponseField_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."RoutingFormResponseDenormalized" (
    "id" INTEGER NOT NULL,
    "uuid" TEXT,
    "formId" TEXT NOT NULL,
    "formName" TEXT NOT NULL,
    "formTeamId" INTEGER,
    "formUserId" INTEGER NOT NULL,
    "bookingUid" TEXT,
    "bookingId" INTEGER,
    "bookingStatus" "public"."BookingStatus",
    "bookingStatusOrder" INTEGER,
    "bookingCreatedAt" TIMESTAMP(3),
    "bookingStartTime" TIMESTAMP(3),
    "bookingEndTime" TIMESTAMP(3),
    "bookingUserId" INTEGER,
    "bookingUserName" TEXT,
    "bookingUserEmail" TEXT,
    "bookingUserAvatarUrl" TEXT,
    "bookingAssignmentReason" TEXT,
    "eventTypeId" INTEGER,
    "eventTypeParentId" INTEGER,
    "eventTypeSchedulingType" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "utm_source" TEXT,
    "utm_medium" TEXT,
    "utm_campaign" TEXT,
    "utm_term" TEXT,
    "utm_content" TEXT,

    CONSTRAINT "RoutingFormResponseDenormalized_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Feedback" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,
    "rating" TEXT NOT NULL,
    "comment" TEXT,

    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkflowStep" (
    "id" SERIAL NOT NULL,
    "stepNumber" INTEGER NOT NULL,
    "action" "public"."WorkflowActions" NOT NULL,
    "workflowId" INTEGER NOT NULL,
    "sendTo" TEXT,
    "reminderBody" TEXT,
    "emailSubject" TEXT,
    "template" "public"."WorkflowTemplates" NOT NULL DEFAULT 'REMINDER',
    "numberRequired" BOOLEAN,
    "sender" TEXT,
    "numberVerificationPending" BOOLEAN NOT NULL DEFAULT true,
    "includeCalendarEvent" BOOLEAN NOT NULL DEFAULT false,
    "verifiedAt" TIMESTAMP(3),
    "agentId" TEXT,
    "inboundAgentId" TEXT,

    CONSTRAINT "WorkflowStep_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Workflow" (
    "id" SERIAL NOT NULL,
    "position" INTEGER NOT NULL DEFAULT 0,
    "name" TEXT NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "isActiveOnAll" BOOLEAN NOT NULL DEFAULT false,
    "trigger" "public"."WorkflowTriggerEvents" NOT NULL,
    "time" INTEGER,
    "timeUnit" "public"."TimeUnit",
    "type" "public"."WorkflowType" NOT NULL DEFAULT 'EVENT_TYPE',

    CONSTRAINT "Workflow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AIPhoneCallConfiguration" (
    "id" SERIAL NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "templateType" TEXT NOT NULL DEFAULT 'CUSTOM_TEMPLATE',
    "schedulerName" TEXT,
    "generalPrompt" TEXT,
    "yourPhoneNumber" TEXT NOT NULL,
    "numberToCall" TEXT NOT NULL,
    "guestName" TEXT,
    "guestEmail" TEXT,
    "guestCompany" TEXT,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "beginMessage" TEXT,
    "llmId" TEXT,

    CONSTRAINT "AIPhoneCallConfiguration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkflowsOnEventTypes" (
    "id" SERIAL NOT NULL,
    "workflowId" INTEGER NOT NULL,
    "eventTypeId" INTEGER NOT NULL,

    CONSTRAINT "WorkflowsOnEventTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkflowsOnRoutingForms" (
    "id" SERIAL NOT NULL,
    "workflowId" INTEGER NOT NULL,
    "routingFormId" TEXT NOT NULL,

    CONSTRAINT "WorkflowsOnRoutingForms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkflowsOnTeams" (
    "id" SERIAL NOT NULL,
    "workflowId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,

    CONSTRAINT "WorkflowsOnTeams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Deployment" (
    "id" INTEGER NOT NULL DEFAULT 1,
    "logo" TEXT,
    "theme" JSONB,
    "licenseKey" TEXT,
    "signatureTokenEncrypted" TEXT,
    "agreedLicenseAt" TIMESTAMP(3),

    CONSTRAINT "Deployment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkflowReminder" (
    "id" SERIAL NOT NULL,
    "uuid" TEXT,
    "bookingUid" TEXT,
    "method" "public"."WorkflowMethods" NOT NULL,
    "scheduledDate" TIMESTAMP(3) NOT NULL,
    "referenceId" TEXT,
    "scheduled" BOOLEAN NOT NULL,
    "workflowStepId" INTEGER,
    "cancelled" BOOLEAN,
    "seatReferenceId" TEXT,
    "isMandatoryReminder" BOOLEAN DEFAULT false,
    "retryCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "WorkflowReminder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WebhookScheduledTriggers" (
    "id" SERIAL NOT NULL,
    "jobName" TEXT,
    "subscriberUrl" TEXT NOT NULL,
    "payload" TEXT NOT NULL,
    "startAfter" TIMESTAMP(3) NOT NULL,
    "retryCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "appId" TEXT,
    "webhookId" TEXT,
    "bookingId" INTEGER,

    CONSTRAINT "WebhookScheduledTriggers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BookingSeat" (
    "id" SERIAL NOT NULL,
    "referenceUid" TEXT NOT NULL,
    "bookingId" INTEGER NOT NULL,
    "attendeeId" INTEGER NOT NULL,
    "data" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BookingSeat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."VerifiedNumber" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "phoneNumber" TEXT NOT NULL,

    CONSTRAINT "VerifiedNumber_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."VerifiedEmail" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "email" TEXT NOT NULL,

    CONSTRAINT "VerifiedEmail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Feature" (
    "slug" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "description" TEXT,
    "type" "public"."FeatureType" DEFAULT 'RELEASE',
    "stale" BOOLEAN DEFAULT false,
    "lastUsedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedBy" INTEGER,

    CONSTRAINT "Feature_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "public"."UserFeatures" (
    "userId" INTEGER NOT NULL,
    "featureId" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserFeatures_pkey" PRIMARY KEY ("userId","featureId")
);

-- CreateTable
CREATE TABLE "public"."TeamFeatures" (
    "teamId" INTEGER NOT NULL,
    "featureId" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeamFeatures_pkey" PRIMARY KEY ("teamId","featureId")
);

-- CreateTable
CREATE TABLE "public"."SelectedSlots" (
    "id" SERIAL NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "slotUtcStartDate" TIMESTAMP(3) NOT NULL,
    "slotUtcEndDate" TIMESTAMP(3) NOT NULL,
    "uid" TEXT NOT NULL,
    "releaseAt" TIMESTAMP(3) NOT NULL,
    "isSeat" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "SelectedSlots_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OAuthClient" (
    "clientId" TEXT NOT NULL,
    "redirectUri" TEXT NOT NULL,
    "clientSecret" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "logo" TEXT,

    CONSTRAINT "OAuthClient_pkey" PRIMARY KEY ("clientId")
);

-- CreateTable
CREATE TABLE "public"."AccessCode" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "clientId" TEXT,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "scopes" "public"."AccessScope"[],
    "userId" INTEGER,
    "teamId" INTEGER,

    CONSTRAINT "AccessCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BookingDenormalized" (
    "id" INTEGER NOT NULL,
    "uid" TEXT NOT NULL,
    "eventTypeId" INTEGER,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),
    "location" TEXT,
    "paid" BOOLEAN NOT NULL,
    "status" "public"."BookingStatus" NOT NULL,
    "rescheduled" BOOLEAN,
    "userId" INTEGER,
    "teamId" INTEGER,
    "eventLength" INTEGER,
    "eventParentId" INTEGER,
    "userEmail" TEXT,
    "userName" TEXT,
    "userUsername" TEXT,
    "ratingFeedback" TEXT,
    "rating" INTEGER,
    "noShowHost" BOOLEAN,
    "isTeamBooking" BOOLEAN NOT NULL,

    CONSTRAINT "BookingDenormalized_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CalendarCache" (
    "id" TEXT,
    "key" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "credentialId" INTEGER NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "CalendarCache_pkey" PRIMARY KEY ("credentialId","key")
);

-- CreateTable
CREATE TABLE "public"."TempOrgRedirect" (
    "id" SERIAL NOT NULL,
    "from" TEXT NOT NULL,
    "fromOrgId" INTEGER NOT NULL,
    "type" "public"."RedirectType" NOT NULL,
    "toUrl" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TempOrgRedirect_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."avatars" (
    "teamId" INTEGER NOT NULL DEFAULT 0,
    "userId" INTEGER NOT NULL DEFAULT 0,
    "data" TEXT NOT NULL,
    "objectKey" TEXT NOT NULL,
    "isBanner" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "public"."OutOfOfficeEntry" (
    "id" SERIAL NOT NULL,
    "uuid" TEXT NOT NULL,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3) NOT NULL,
    "notes" TEXT,
    "userId" INTEGER NOT NULL,
    "toUserId" INTEGER,
    "reasonId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OutOfOfficeEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OutOfOfficeReason" (
    "id" SERIAL NOT NULL,
    "emoji" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "userId" INTEGER,

    CONSTRAINT "OutOfOfficeReason_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."PlatformOAuthClient" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "secret" TEXT NOT NULL,
    "permissions" INTEGER NOT NULL,
    "logo" TEXT,
    "redirectUris" TEXT[],
    "organizationId" INTEGER NOT NULL,
    "bookingRedirectUri" TEXT,
    "bookingCancelRedirectUri" TEXT,
    "bookingRescheduleRedirectUri" TEXT,
    "areEmailsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "areDefaultEventTypesEnabled" BOOLEAN NOT NULL DEFAULT true,
    "areCalendarEventsEnabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PlatformOAuthClient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."PlatformAuthorizationToken" (
    "id" TEXT NOT NULL,
    "platformOAuthClientId" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PlatformAuthorizationToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AccessToken" (
    "id" SERIAL NOT NULL,
    "secret" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "platformOAuthClientId" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "AccessToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."RefreshToken" (
    "id" SERIAL NOT NULL,
    "secret" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "platformOAuthClientId" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "RefreshToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DSyncData" (
    "id" SERIAL NOT NULL,
    "directoryId" TEXT NOT NULL,
    "tenant" TEXT NOT NULL,
    "organizationId" INTEGER,

    CONSTRAINT "DSyncData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DSyncTeamGroupMapping" (
    "id" SERIAL NOT NULL,
    "organizationId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,
    "directoryId" TEXT NOT NULL,
    "groupName" TEXT NOT NULL,

    CONSTRAINT "DSyncTeamGroupMapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SecondaryEmail" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "email" TEXT NOT NULL,
    "emailVerified" TIMESTAMP(3),

    CONSTRAINT "SecondaryEmail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Task" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "scheduledAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "succeededAt" TIMESTAMP(3),
    "type" TEXT NOT NULL,
    "payload" TEXT NOT NULL,
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "maxAttempts" INTEGER NOT NULL DEFAULT 3,
    "lastError" TEXT,
    "lastFailedAttemptAt" TIMESTAMP(3),
    "referenceUid" TEXT,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ManagedOrganization" (
    "managedOrganizationId" INTEGER NOT NULL,
    "managerOrganizationId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "public"."PlatformBilling" (
    "id" INTEGER NOT NULL,
    "customerId" TEXT NOT NULL,
    "subscriptionId" TEXT,
    "priceId" TEXT,
    "plan" TEXT NOT NULL DEFAULT 'none',
    "billingCycleStart" INTEGER,
    "billingCycleEnd" INTEGER,
    "overdue" BOOLEAN DEFAULT false,
    "managerBillingId" INTEGER,

    CONSTRAINT "PlatformBilling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AttributeOption" (
    "id" TEXT NOT NULL,
    "attributeId" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "isGroup" BOOLEAN NOT NULL DEFAULT false,
    "contains" TEXT[],

    CONSTRAINT "AttributeOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Attribute" (
    "id" TEXT NOT NULL,
    "teamId" INTEGER NOT NULL,
    "type" "public"."AttributeType" NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "usersCanEditRelation" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isWeightsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "isLocked" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Attribute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AttributeToUser" (
    "id" TEXT NOT NULL,
    "memberId" INTEGER NOT NULL,
    "attributeOptionId" TEXT NOT NULL,
    "weight" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdById" INTEGER,
    "createdByDSyncId" TEXT,
    "updatedAt" TIMESTAMP(3),
    "updatedById" INTEGER,
    "updatedByDSyncId" TEXT,

    CONSTRAINT "AttributeToUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AssignmentReason" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "bookingId" INTEGER NOT NULL,
    "reasonEnum" "public"."AssignmentReasonEnum" NOT NULL,
    "reasonString" TEXT NOT NULL,

    CONSTRAINT "AssignmentReason_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DelegationCredential" (
    "id" TEXT NOT NULL,
    "workspacePlatformId" INTEGER NOT NULL,
    "serviceAccountKey" JSONB NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "lastEnabledAt" TIMESTAMP(3),
    "lastDisabledAt" TIMESTAMP(3),
    "organizationId" INTEGER NOT NULL,
    "domain" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DelegationCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DomainWideDelegation" (
    "id" TEXT NOT NULL,
    "workspacePlatformId" INTEGER NOT NULL,
    "serviceAccountKey" JSONB NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "organizationId" INTEGER NOT NULL,
    "domain" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DomainWideDelegation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkspacePlatform" (
    "id" SERIAL NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "defaultServiceAccountKey" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "WorkspacePlatform_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."EventTypeTranslation" (
    "uid" TEXT NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "field" "public"."EventTypeAutoTranslatedField" NOT NULL,
    "sourceLocale" TEXT NOT NULL,
    "targetLocale" TEXT NOT NULL,
    "translatedText" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" INTEGER,

    CONSTRAINT "EventTypeTranslation_pkey" PRIMARY KEY ("uid")
);

-- CreateTable
CREATE TABLE "public"."Watchlist" (
    "id" UUID NOT NULL,
    "type" "public"."WatchlistType" NOT NULL,
    "value" TEXT NOT NULL,
    "description" TEXT,
    "isGlobal" BOOLEAN NOT NULL DEFAULT false,
    "organizationId" INTEGER,
    "action" "public"."WatchlistAction" NOT NULL DEFAULT 'REPORT',
    "source" "public"."WatchlistSource" NOT NULL DEFAULT 'MANUAL',
    "lastUpdatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Watchlist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WatchlistAudit" (
    "id" UUID NOT NULL,
    "type" "public"."WatchlistType" NOT NULL,
    "value" TEXT NOT NULL,
    "description" TEXT,
    "action" "public"."WatchlistAction" NOT NULL DEFAULT 'REPORT',
    "changedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "changedByUserId" INTEGER,
    "watchlistId" UUID NOT NULL,

    CONSTRAINT "WatchlistAudit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WatchlistEventAudit" (
    "id" UUID NOT NULL,
    "watchlistId" UUID NOT NULL,
    "eventTypeId" INTEGER NOT NULL,
    "actionTaken" "public"."WatchlistAction" NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WatchlistEventAudit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BookingReport" (
    "id" UUID NOT NULL,
    "bookingUid" TEXT NOT NULL,
    "bookerEmail" TEXT NOT NULL,
    "reportedById" INTEGER,
    "organizationId" INTEGER,
    "reason" "public"."BookingReportReason" NOT NULL,
    "description" TEXT,
    "cancelled" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "status" "public"."BookingReportStatus" NOT NULL DEFAULT 'PENDING',
    "watchlistId" UUID,

    CONSTRAINT "BookingReport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OrganizationOnboarding" (
    "id" TEXT NOT NULL,
    "createdById" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orgOwnerEmail" TEXT NOT NULL,
    "error" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "organizationId" INTEGER,
    "billingPeriod" "public"."BillingPeriod" NOT NULL,
    "pricePerSeat" DOUBLE PRECISION NOT NULL,
    "seats" INTEGER NOT NULL,
    "isPlatform" BOOLEAN NOT NULL DEFAULT false,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "logo" TEXT,
    "bio" TEXT,
    "brandColor" TEXT,
    "bannerUrl" TEXT,
    "isDomainConfigured" BOOLEAN NOT NULL DEFAULT false,
    "stripeCustomerId" TEXT,
    "stripeSubscriptionId" TEXT,
    "stripeSubscriptionItemId" TEXT,
    "invitedMembers" JSONB NOT NULL DEFAULT '[]',
    "teams" JSONB NOT NULL DEFAULT '[]',
    "isComplete" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "OrganizationOnboarding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."App_RoutingForms_IncompleteBookingActions" (
    "id" SERIAL NOT NULL,
    "formId" TEXT NOT NULL,
    "actionType" "public"."IncompleteBookingActionType" NOT NULL,
    "data" JSONB NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "credentialId" INTEGER,

    CONSTRAINT "App_RoutingForms_IncompleteBookingActions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."InternalNotePreset" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "cancellationReason" TEXT,
    "teamId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InternalNotePreset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."FilterSegment" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "tableIdentifier" TEXT NOT NULL,
    "scope" "public"."FilterSegmentScope" NOT NULL,
    "activeFilters" JSONB,
    "sorting" JSONB,
    "columnVisibility" JSONB,
    "columnSizing" JSONB,
    "perPage" INTEGER NOT NULL,
    "searchTerm" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "teamId" INTEGER,

    CONSTRAINT "FilterSegment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserFilterSegmentPreference" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "tableIdentifier" TEXT NOT NULL,
    "segmentId" INTEGER,
    "systemSegmentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserFilterSegmentPreference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BookingInternalNote" (
    "id" SERIAL NOT NULL,
    "notePresetId" INTEGER,
    "text" TEXT,
    "bookingId" INTEGER NOT NULL,
    "createdById" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BookingInternalNote_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."WorkflowOptOutContact" (
    "id" SERIAL NOT NULL,
    "type" "public"."WorkflowContactType" NOT NULL,
    "value" TEXT NOT NULL,
    "optedOut" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WorkflowOptOutContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Role" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "color" TEXT,
    "description" TEXT,
    "teamId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "type" "public"."RoleType" NOT NULL DEFAULT 'CUSTOM',

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."RolePermission" (
    "id" TEXT NOT NULL,
    "roleId" TEXT NOT NULL,
    "resource" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Agent" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "providerAgentId" TEXT NOT NULL,
    "inboundEventTypeId" INTEGER,
    "outboundEventTypeId" INTEGER,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Agent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CalAiPhoneNumber" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "teamId" INTEGER,
    "phoneNumber" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerPhoneNumberId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "stripeCustomerId" TEXT,
    "stripeSubscriptionId" TEXT,
    "subscriptionStatus" "public"."PhoneNumberSubscriptionStatus",
    "inboundAgentId" TEXT,
    "outboundAgentId" TEXT,

    CONSTRAINT "CalAiPhoneNumber_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeamBilling" (
    "id" TEXT NOT NULL,
    "teamId" INTEGER NOT NULL,
    "subscriptionId" TEXT NOT NULL,
    "subscriptionItemId" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "planName" TEXT NOT NULL,
    "subscriptionStart" TIMESTAMP(3),
    "subscriptionTrialEnd" TIMESTAMP(3),
    "subscriptionEnd" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeamBilling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OrganizationBilling" (
    "id" TEXT NOT NULL,
    "teamId" INTEGER NOT NULL,
    "subscriptionId" TEXT NOT NULL,
    "subscriptionItemId" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "planName" TEXT NOT NULL,
    "subscriptionStart" TIMESTAMP(3),
    "subscriptionTrialEnd" TIMESTAMP(3),
    "subscriptionEnd" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OrganizationBilling_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CalendarCacheEvent" (
    "id" TEXT NOT NULL,
    "selectedCalendarId" TEXT NOT NULL,
    "externalId" TEXT NOT NULL,
    "externalEtag" TEXT NOT NULL,
    "iCalUID" TEXT,
    "iCalSequence" INTEGER NOT NULL DEFAULT 0,
    "summary" TEXT,
    "description" TEXT,
    "location" TEXT,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3) NOT NULL,
    "isAllDay" BOOLEAN NOT NULL DEFAULT false,
    "timeZone" TEXT,
    "status" "public"."CalendarCacheEventStatus" NOT NULL DEFAULT 'confirmed',
    "recurringEventId" TEXT,
    "originalStartTime" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "externalCreatedAt" TIMESTAMP(3),
    "externalUpdatedAt" TIMESTAMP(3),

    CONSTRAINT "CalendarCacheEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."_user_eventtype" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_user_eventtype_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "public"."_PlatformOAuthClientToUser" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_PlatformOAuthClientToUser_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "Host_memberId_idx" ON "public"."Host"("memberId");

-- CreateIndex
CREATE INDEX "Host_userId_idx" ON "public"."Host"("userId");

-- CreateIndex
CREATE INDEX "Host_eventTypeId_idx" ON "public"."Host"("eventTypeId");

-- CreateIndex
CREATE INDEX "Host_scheduleId_idx" ON "public"."Host"("scheduleId");

-- CreateIndex
CREATE INDEX "HostGroup_name_idx" ON "public"."HostGroup"("name");

-- CreateIndex
CREATE INDEX "HostGroup_eventTypeId_idx" ON "public"."HostGroup"("eventTypeId");

-- CreateIndex
CREATE INDEX "VideoCallGuest_bookingUid_idx" ON "public"."VideoCallGuest"("bookingUid");

-- CreateIndex
CREATE INDEX "VideoCallGuest_email_idx" ON "public"."VideoCallGuest"("email");

-- CreateIndex
CREATE UNIQUE INDEX "VideoCallGuest_bookingUid_email_key" ON "public"."VideoCallGuest"("bookingUid", "email");

-- CreateIndex
CREATE INDEX "EventType_userId_idx" ON "public"."EventType"("userId");

-- CreateIndex
CREATE INDEX "EventType_teamId_idx" ON "public"."EventType"("teamId");

-- CreateIndex
CREATE INDEX "EventType_profileId_idx" ON "public"."EventType"("profileId");

-- CreateIndex
CREATE INDEX "EventType_scheduleId_idx" ON "public"."EventType"("scheduleId");

-- CreateIndex
CREATE INDEX "EventType_secondaryEmailId_idx" ON "public"."EventType"("secondaryEmailId");

-- CreateIndex
CREATE INDEX "EventType_parentId_idx" ON "public"."EventType"("parentId");

-- CreateIndex
CREATE INDEX "EventType_restrictionScheduleId_idx" ON "public"."EventType"("restrictionScheduleId");

-- CreateIndex
CREATE UNIQUE INDEX "EventType_userId_slug_key" ON "public"."EventType"("userId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "EventType_teamId_slug_key" ON "public"."EventType"("teamId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "EventType_userId_parentId_key" ON "public"."EventType"("userId", "parentId");

-- CreateIndex
CREATE INDEX "Credential_appId_idx" ON "public"."Credential"("appId");

-- CreateIndex
CREATE INDEX "Credential_subscriptionId_idx" ON "public"."Credential"("subscriptionId");

-- CreateIndex
CREATE INDEX "Credential_invalid_idx" ON "public"."Credential"("invalid");

-- CreateIndex
CREATE INDEX "Credential_userId_delegationCredentialId_idx" ON "public"."Credential"("userId", "delegationCredentialId");

-- CreateIndex
CREATE UNIQUE INDEX "DestinationCalendar_userId_key" ON "public"."DestinationCalendar"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "DestinationCalendar_eventTypeId_key" ON "public"."DestinationCalendar"("eventTypeId");

-- CreateIndex
CREATE INDEX "DestinationCalendar_userId_idx" ON "public"."DestinationCalendar"("userId");

-- CreateIndex
CREATE INDEX "DestinationCalendar_eventTypeId_idx" ON "public"."DestinationCalendar"("eventTypeId");

-- CreateIndex
CREATE INDEX "DestinationCalendar_credentialId_idx" ON "public"."DestinationCalendar"("credentialId");

-- CreateIndex
CREATE UNIQUE INDEX "UserPassword_userId_key" ON "public"."UserPassword"("userId");

-- CreateIndex
CREATE INDEX "TravelSchedule_startDate_idx" ON "public"."TravelSchedule"("startDate");

-- CreateIndex
CREATE INDEX "TravelSchedule_endDate_idx" ON "public"."TravelSchedule"("endDate");

-- CreateIndex
CREATE UNIQUE INDEX "users_uuid_key" ON "public"."users"("uuid");

-- CreateIndex
CREATE INDEX "users_username_idx" ON "public"."users"("username");

-- CreateIndex
CREATE INDEX "users_emailVerified_idx" ON "public"."users"("emailVerified");

-- CreateIndex
CREATE INDEX "users_identityProvider_idx" ON "public"."users"("identityProvider");

-- CreateIndex
CREATE INDEX "users_identityProviderId_idx" ON "public"."users"("identityProviderId");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "public"."users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_username_key" ON "public"."users"("email", "username");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_organizationId_key" ON "public"."users"("username", "organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "users_movedToProfileId_key" ON "public"."users"("movedToProfileId");

-- CreateIndex
CREATE INDEX "NotificationsSubscriptions_userId_subscription_idx" ON "public"."NotificationsSubscriptions"("userId", "subscription");

-- CreateIndex
CREATE INDEX "Profile_uid_idx" ON "public"."Profile"("uid");

-- CreateIndex
CREATE INDEX "Profile_userId_idx" ON "public"."Profile"("userId");

-- CreateIndex
CREATE INDEX "Profile_organizationId_idx" ON "public"."Profile"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_organizationId_key" ON "public"."Profile"("userId", "organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_username_organizationId_key" ON "public"."Profile"("username", "organizationId");

-- CreateIndex
CREATE INDEX "Team_parentId_idx" ON "public"."Team"("parentId");

-- CreateIndex
CREATE UNIQUE INDEX "Team_slug_parentId_key" ON "public"."Team"("slug", "parentId");

-- CreateIndex
CREATE UNIQUE INDEX "CreditBalance_teamId_key" ON "public"."CreditBalance"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "CreditBalance_userId_key" ON "public"."CreditBalance"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "CreditExpenseLog_externalRef_key" ON "public"."CreditExpenseLog"("externalRef");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationSettings_organizationId_key" ON "public"."OrganizationSettings"("organizationId");

-- CreateIndex
CREATE INDEX "Membership_teamId_idx" ON "public"."Membership"("teamId");

-- CreateIndex
CREATE INDEX "Membership_userId_idx" ON "public"."Membership"("userId");

-- CreateIndex
CREATE INDEX "Membership_accepted_idx" ON "public"."Membership"("accepted");

-- CreateIndex
CREATE INDEX "Membership_role_idx" ON "public"."Membership"("role");

-- CreateIndex
CREATE INDEX "Membership_customRoleId_idx" ON "public"."Membership"("customRoleId");

-- CreateIndex
CREATE UNIQUE INDEX "Membership_userId_teamId_key" ON "public"."Membership"("userId", "teamId");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "public"."VerificationToken"("token");

-- CreateIndex
CREATE INDEX "VerificationToken_token_idx" ON "public"."VerificationToken"("token");

-- CreateIndex
CREATE INDEX "VerificationToken_teamId_idx" ON "public"."VerificationToken"("teamId");

-- CreateIndex
CREATE INDEX "VerificationToken_secondaryEmailId_idx" ON "public"."VerificationToken"("secondaryEmailId");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "public"."VerificationToken"("identifier", "token");

-- CreateIndex
CREATE UNIQUE INDEX "InstantMeetingToken_token_key" ON "public"."InstantMeetingToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "InstantMeetingToken_bookingId_key" ON "public"."InstantMeetingToken"("bookingId");

-- CreateIndex
CREATE INDEX "InstantMeetingToken_token_idx" ON "public"."InstantMeetingToken"("token");

-- CreateIndex
CREATE INDEX "BookingReference_bookingId_idx" ON "public"."BookingReference"("bookingId");

-- CreateIndex
CREATE INDEX "BookingReference_type_idx" ON "public"."BookingReference"("type");

-- CreateIndex
CREATE INDEX "BookingReference_uid_idx" ON "public"."BookingReference"("uid");

-- CreateIndex
CREATE INDEX "Attendee_email_idx" ON "public"."Attendee"("email");

-- CreateIndex
CREATE INDEX "Attendee_bookingId_idx" ON "public"."Attendee"("bookingId");

-- CreateIndex
CREATE UNIQUE INDEX "Booking_uid_key" ON "public"."Booking"("uid");

-- CreateIndex
CREATE UNIQUE INDEX "Booking_idempotencyKey_key" ON "public"."Booking"("idempotencyKey");

-- CreateIndex
CREATE UNIQUE INDEX "Booking_oneTimePassword_key" ON "public"."Booking"("oneTimePassword");

-- CreateIndex
CREATE INDEX "Booking_eventTypeId_idx" ON "public"."Booking"("eventTypeId");

-- CreateIndex
CREATE INDEX "Booking_userId_idx" ON "public"."Booking"("userId");

-- CreateIndex
CREATE INDEX "Booking_destinationCalendarId_idx" ON "public"."Booking"("destinationCalendarId");

-- CreateIndex
CREATE INDEX "Booking_recurringEventId_idx" ON "public"."Booking"("recurringEventId");

-- CreateIndex
CREATE INDEX "Booking_uid_idx" ON "public"."Booking"("uid");

-- CreateIndex
CREATE INDEX "Booking_status_idx" ON "public"."Booking"("status");

-- CreateIndex
CREATE INDEX "Booking_startTime_endTime_status_idx" ON "public"."Booking"("startTime", "endTime", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Tracking_bookingId_key" ON "public"."Tracking"("bookingId");

-- CreateIndex
CREATE INDEX "Schedule_userId_idx" ON "public"."Schedule"("userId");

-- CreateIndex
CREATE INDEX "Availability_userId_idx" ON "public"."Availability"("userId");

-- CreateIndex
CREATE INDEX "Availability_eventTypeId_idx" ON "public"."Availability"("eventTypeId");

-- CreateIndex
CREATE INDEX "Availability_scheduleId_idx" ON "public"."Availability"("scheduleId");

-- CreateIndex
CREATE INDEX "SelectedCalendar_userId_idx" ON "public"."SelectedCalendar"("userId");

-- CreateIndex
CREATE INDEX "SelectedCalendar_externalId_idx" ON "public"."SelectedCalendar"("externalId");

-- CreateIndex
CREATE INDEX "SelectedCalendar_eventTypeId_idx" ON "public"."SelectedCalendar"("eventTypeId");

-- CreateIndex
CREATE INDEX "SelectedCalendar_credentialId_idx" ON "public"."SelectedCalendar"("credentialId");

-- CreateIndex
CREATE INDEX "SelectedCalendar_watch_idx" ON "public"."SelectedCalendar"("integration", "googleChannelExpiration", "error", "watchAttempts", "maxAttempts");

-- CreateIndex
CREATE INDEX "SelectedCalendar_unwatch_idx" ON "public"."SelectedCalendar"("integration", "googleChannelExpiration", "error", "unwatchAttempts", "maxAttempts");

-- CreateIndex
CREATE UNIQUE INDEX "SelectedCalendar_userId_integration_externalId_eventTypeId_key" ON "public"."SelectedCalendar"("userId", "integration", "externalId", "eventTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "SelectedCalendar_googleChannelId_eventTypeId_key" ON "public"."SelectedCalendar"("googleChannelId", "eventTypeId");

-- CreateIndex
CREATE INDEX "EventTypeCustomInput_eventTypeId_idx" ON "public"."EventTypeCustomInput"("eventTypeId");

-- CreateIndex
CREATE INDEX "ReminderMail_referenceId_idx" ON "public"."ReminderMail"("referenceId");

-- CreateIndex
CREATE INDEX "ReminderMail_reminderType_idx" ON "public"."ReminderMail"("reminderType");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_uid_key" ON "public"."Payment"("uid");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_externalId_key" ON "public"."Payment"("externalId");

-- CreateIndex
CREATE INDEX "Payment_bookingId_idx" ON "public"."Payment"("bookingId");

-- CreateIndex
CREATE INDEX "Payment_externalId_idx" ON "public"."Payment"("externalId");

-- CreateIndex
CREATE UNIQUE INDEX "Webhook_id_key" ON "public"."Webhook"("id");

-- CreateIndex
CREATE INDEX "Webhook_active_idx" ON "public"."Webhook"("active");

-- CreateIndex
CREATE UNIQUE INDEX "Webhook_userId_subscriberUrl_key" ON "public"."Webhook"("userId", "subscriberUrl");

-- CreateIndex
CREATE UNIQUE INDEX "Webhook_platformOAuthClientId_subscriberUrl_key" ON "public"."Webhook"("platformOAuthClientId", "subscriberUrl");

-- CreateIndex
CREATE INDEX "Impersonations_impersonatedUserId_idx" ON "public"."Impersonations"("impersonatedUserId");

-- CreateIndex
CREATE INDEX "Impersonations_impersonatedById_idx" ON "public"."Impersonations"("impersonatedById");

-- CreateIndex
CREATE UNIQUE INDEX "ApiKey_id_key" ON "public"."ApiKey"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ApiKey_hashedKey_key" ON "public"."ApiKey"("hashedKey");

-- CreateIndex
CREATE INDEX "ApiKey_userId_idx" ON "public"."ApiKey"("userId");

-- CreateIndex
CREATE INDEX "RateLimit_apiKeyId_idx" ON "public"."RateLimit"("apiKeyId");

-- CreateIndex
CREATE UNIQUE INDEX "HashedLink_link_key" ON "public"."HashedLink"("link");

-- CreateIndex
CREATE INDEX "HashedLink_eventTypeId_idx" ON "public"."HashedLink"("eventTypeId");

-- CreateIndex
CREATE INDEX "Account_userId_idx" ON "public"."Account"("userId");

-- CreateIndex
CREATE INDEX "Account_type_idx" ON "public"."Account"("type");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "public"."Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "public"."Session"("sessionToken");

-- CreateIndex
CREATE INDEX "Session_userId_idx" ON "public"."Session"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "App_slug_key" ON "public"."App"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "App_dirName_key" ON "public"."App"("dirName");

-- CreateIndex
CREATE INDEX "App_enabled_idx" ON "public"."App"("enabled");

-- CreateIndex
CREATE INDEX "App_RoutingForms_Form_userId_idx" ON "public"."App_RoutingForms_Form"("userId");

-- CreateIndex
CREATE INDEX "App_RoutingForms_Form_disabled_idx" ON "public"."App_RoutingForms_Form"("disabled");

-- CreateIndex
CREATE UNIQUE INDEX "App_RoutingForms_FormResponse_routedToBookingUid_key" ON "public"."App_RoutingForms_FormResponse"("routedToBookingUid");

-- CreateIndex
CREATE INDEX "App_RoutingForms_FormResponse_formFillerId_idx" ON "public"."App_RoutingForms_FormResponse"("formFillerId");

-- CreateIndex
CREATE INDEX "App_RoutingForms_FormResponse_formId_idx" ON "public"."App_RoutingForms_FormResponse"("formId");

-- CreateIndex
CREATE INDEX "App_RoutingForms_FormResponse_routedToBookingUid_idx" ON "public"."App_RoutingForms_FormResponse"("routedToBookingUid");

-- CreateIndex
CREATE UNIQUE INDEX "App_RoutingForms_FormResponse_formFillerId_formId_key" ON "public"."App_RoutingForms_FormResponse"("formFillerId", "formId");

-- CreateIndex
CREATE UNIQUE INDEX "App_RoutingForms_QueuedFormResponse_actualResponseId_key" ON "public"."App_RoutingForms_QueuedFormResponse"("actualResponseId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseField_responseId_idx" ON "public"."RoutingFormResponseField"("responseId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseField_fieldId_idx" ON "public"."RoutingFormResponseField"("fieldId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseField_valueNumber_idx" ON "public"."RoutingFormResponseField"("valueNumber");

-- CreateIndex
CREATE INDEX "RoutingFormResponseField_valueStringArray_idx" ON "public"."RoutingFormResponseField" USING GIN ("valueStringArray");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_formId_idx" ON "public"."RoutingFormResponseDenormalized"("formId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_formTeamId_idx" ON "public"."RoutingFormResponseDenormalized"("formTeamId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_formUserId_idx" ON "public"."RoutingFormResponseDenormalized"("formUserId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_formId_createdAt_idx" ON "public"."RoutingFormResponseDenormalized"("formId", "createdAt");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_bookingId_idx" ON "public"."RoutingFormResponseDenormalized"("bookingId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_bookingUserId_idx" ON "public"."RoutingFormResponseDenormalized"("bookingUserId");

-- CreateIndex
CREATE INDEX "RoutingFormResponseDenormalized_eventTypeId_eventTypeParent_idx" ON "public"."RoutingFormResponseDenormalized"("eventTypeId", "eventTypeParentId");

-- CreateIndex
CREATE INDEX "Feedback_userId_idx" ON "public"."Feedback"("userId");

-- CreateIndex
CREATE INDEX "Feedback_rating_idx" ON "public"."Feedback"("rating");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowStep_agentId_key" ON "public"."WorkflowStep"("agentId");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowStep_inboundAgentId_key" ON "public"."WorkflowStep"("inboundAgentId");

-- CreateIndex
CREATE INDEX "WorkflowStep_workflowId_idx" ON "public"."WorkflowStep"("workflowId");

-- CreateIndex
CREATE INDEX "Workflow_userId_idx" ON "public"."Workflow"("userId");

-- CreateIndex
CREATE INDEX "Workflow_teamId_idx" ON "public"."Workflow"("teamId");

-- CreateIndex
CREATE INDEX "AIPhoneCallConfiguration_eventTypeId_idx" ON "public"."AIPhoneCallConfiguration"("eventTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "AIPhoneCallConfiguration_eventTypeId_key" ON "public"."AIPhoneCallConfiguration"("eventTypeId");

-- CreateIndex
CREATE INDEX "WorkflowsOnEventTypes_workflowId_idx" ON "public"."WorkflowsOnEventTypes"("workflowId");

-- CreateIndex
CREATE INDEX "WorkflowsOnEventTypes_eventTypeId_idx" ON "public"."WorkflowsOnEventTypes"("eventTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowsOnEventTypes_workflowId_eventTypeId_key" ON "public"."WorkflowsOnEventTypes"("workflowId", "eventTypeId");

-- CreateIndex
CREATE INDEX "WorkflowsOnRoutingForms_workflowId_idx" ON "public"."WorkflowsOnRoutingForms"("workflowId");

-- CreateIndex
CREATE INDEX "WorkflowsOnRoutingForms_routingFormId_idx" ON "public"."WorkflowsOnRoutingForms"("routingFormId");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowsOnRoutingForms_workflowId_routingFormId_key" ON "public"."WorkflowsOnRoutingForms"("workflowId", "routingFormId");

-- CreateIndex
CREATE INDEX "WorkflowsOnTeams_workflowId_idx" ON "public"."WorkflowsOnTeams"("workflowId");

-- CreateIndex
CREATE INDEX "WorkflowsOnTeams_teamId_idx" ON "public"."WorkflowsOnTeams"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowsOnTeams_workflowId_teamId_key" ON "public"."WorkflowsOnTeams"("workflowId", "teamId");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowReminder_uuid_key" ON "public"."WorkflowReminder"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowReminder_referenceId_key" ON "public"."WorkflowReminder"("referenceId");

-- CreateIndex
CREATE INDEX "WorkflowReminder_bookingUid_idx" ON "public"."WorkflowReminder"("bookingUid");

-- CreateIndex
CREATE INDEX "WorkflowReminder_workflowStepId_idx" ON "public"."WorkflowReminder"("workflowStepId");

-- CreateIndex
CREATE INDEX "WorkflowReminder_seatReferenceId_idx" ON "public"."WorkflowReminder"("seatReferenceId");

-- CreateIndex
CREATE INDEX "WorkflowReminder_method_scheduled_scheduledDate_idx" ON "public"."WorkflowReminder"("method", "scheduled", "scheduledDate");

-- CreateIndex
CREATE INDEX "WorkflowReminder_cancelled_scheduledDate_idx" ON "public"."WorkflowReminder"("cancelled", "scheduledDate");

-- CreateIndex
CREATE UNIQUE INDEX "BookingSeat_referenceUid_key" ON "public"."BookingSeat"("referenceUid");

-- CreateIndex
CREATE UNIQUE INDEX "BookingSeat_attendeeId_key" ON "public"."BookingSeat"("attendeeId");

-- CreateIndex
CREATE INDEX "BookingSeat_bookingId_idx" ON "public"."BookingSeat"("bookingId");

-- CreateIndex
CREATE INDEX "BookingSeat_attendeeId_idx" ON "public"."BookingSeat"("attendeeId");

-- CreateIndex
CREATE INDEX "VerifiedNumber_userId_idx" ON "public"."VerifiedNumber"("userId");

-- CreateIndex
CREATE INDEX "VerifiedNumber_teamId_idx" ON "public"."VerifiedNumber"("teamId");

-- CreateIndex
CREATE INDEX "VerifiedEmail_userId_idx" ON "public"."VerifiedEmail"("userId");

-- CreateIndex
CREATE INDEX "VerifiedEmail_teamId_idx" ON "public"."VerifiedEmail"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "Feature_slug_key" ON "public"."Feature"("slug");

-- CreateIndex
CREATE INDEX "Feature_enabled_idx" ON "public"."Feature"("enabled");

-- CreateIndex
CREATE INDEX "Feature_stale_idx" ON "public"."Feature"("stale");

-- CreateIndex
CREATE INDEX "UserFeatures_userId_featureId_idx" ON "public"."UserFeatures"("userId", "featureId");

-- CreateIndex
CREATE INDEX "TeamFeatures_teamId_featureId_idx" ON "public"."TeamFeatures"("teamId", "featureId");

-- CreateIndex
CREATE UNIQUE INDEX "SelectedSlots_userId_slotUtcStartDate_slotUtcEndDate_uid_key" ON "public"."SelectedSlots"("userId", "slotUtcStartDate", "slotUtcEndDate", "uid");

-- CreateIndex
CREATE UNIQUE INDEX "OAuthClient_clientId_key" ON "public"."OAuthClient"("clientId");

-- CreateIndex
CREATE UNIQUE INDEX "BookingDenormalized_id_key" ON "public"."BookingDenormalized"("id");

-- CreateIndex
CREATE INDEX "BookingDenormalized_userId_idx" ON "public"."BookingDenormalized"("userId");

-- CreateIndex
CREATE INDEX "BookingDenormalized_createdAt_idx" ON "public"."BookingDenormalized"("createdAt");

-- CreateIndex
CREATE INDEX "BookingDenormalized_eventTypeId_idx" ON "public"."BookingDenormalized"("eventTypeId");

-- CreateIndex
CREATE INDEX "BookingDenormalized_eventParentId_idx" ON "public"."BookingDenormalized"("eventParentId");

-- CreateIndex
CREATE INDEX "BookingDenormalized_teamId_idx" ON "public"."BookingDenormalized"("teamId");

-- CreateIndex
CREATE INDEX "BookingDenormalized_startTime_idx" ON "public"."BookingDenormalized"("startTime");

-- CreateIndex
CREATE INDEX "BookingDenormalized_endTime_idx" ON "public"."BookingDenormalized"("endTime");

-- CreateIndex
CREATE INDEX "BookingDenormalized_status_idx" ON "public"."BookingDenormalized"("status");

-- CreateIndex
CREATE INDEX "BookingDenormalized_teamId_isTeamBooking_idx" ON "public"."BookingDenormalized"("teamId", "isTeamBooking");

-- CreateIndex
CREATE INDEX "BookingDenormalized_userId_isTeamBooking_idx" ON "public"."BookingDenormalized"("userId", "isTeamBooking");

-- CreateIndex
CREATE INDEX "BookingDenormalized_startTime_endTime_idx" ON "public"."BookingDenormalized"("startTime", "endTime");

-- CreateIndex
CREATE INDEX "CalendarCache_userId_key_idx" ON "public"."CalendarCache"("userId", "key");

-- CreateIndex
CREATE UNIQUE INDEX "CalendarCache_credentialId_key_key" ON "public"."CalendarCache"("credentialId", "key");

-- CreateIndex
CREATE UNIQUE INDEX "TempOrgRedirect_from_type_fromOrgId_key" ON "public"."TempOrgRedirect"("from", "type", "fromOrgId");

-- CreateIndex
CREATE UNIQUE INDEX "avatars_objectKey_key" ON "public"."avatars"("objectKey");

-- CreateIndex
CREATE UNIQUE INDEX "avatars_teamId_userId_isBanner_key" ON "public"."avatars"("teamId", "userId", "isBanner");

-- CreateIndex
CREATE UNIQUE INDEX "OutOfOfficeEntry_uuid_key" ON "public"."OutOfOfficeEntry"("uuid");

-- CreateIndex
CREATE INDEX "OutOfOfficeEntry_uuid_idx" ON "public"."OutOfOfficeEntry"("uuid");

-- CreateIndex
CREATE INDEX "OutOfOfficeEntry_userId_idx" ON "public"."OutOfOfficeEntry"("userId");

-- CreateIndex
CREATE INDEX "OutOfOfficeEntry_toUserId_idx" ON "public"."OutOfOfficeEntry"("toUserId");

-- CreateIndex
CREATE INDEX "OutOfOfficeEntry_start_end_idx" ON "public"."OutOfOfficeEntry"("start", "end");

-- CreateIndex
CREATE UNIQUE INDEX "OutOfOfficeReason_reason_key" ON "public"."OutOfOfficeReason"("reason");

-- CreateIndex
CREATE UNIQUE INDEX "PlatformAuthorizationToken_userId_platformOAuthClientId_key" ON "public"."PlatformAuthorizationToken"("userId", "platformOAuthClientId");

-- CreateIndex
CREATE UNIQUE INDEX "AccessToken_secret_key" ON "public"."AccessToken"("secret");

-- CreateIndex
CREATE UNIQUE INDEX "RefreshToken_secret_key" ON "public"."RefreshToken"("secret");

-- CreateIndex
CREATE UNIQUE INDEX "DSyncData_directoryId_key" ON "public"."DSyncData"("directoryId");

-- CreateIndex
CREATE UNIQUE INDEX "DSyncData_organizationId_key" ON "public"."DSyncData"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "DSyncTeamGroupMapping_teamId_groupName_key" ON "public"."DSyncTeamGroupMapping"("teamId", "groupName");

-- CreateIndex
CREATE INDEX "SecondaryEmail_userId_idx" ON "public"."SecondaryEmail"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "SecondaryEmail_email_key" ON "public"."SecondaryEmail"("email");

-- CreateIndex
CREATE UNIQUE INDEX "SecondaryEmail_userId_email_key" ON "public"."SecondaryEmail"("userId", "email");

-- CreateIndex
CREATE UNIQUE INDEX "Task_id_key" ON "public"."Task"("id");

-- CreateIndex
CREATE INDEX "Task_succeededAt_idx" ON "public"."Task"("succeededAt");

-- CreateIndex
CREATE INDEX "Task_scheduledAt_succeededAt_idx" ON "public"."Task"("scheduledAt", "succeededAt");

-- CreateIndex
CREATE UNIQUE INDEX "Task_referenceUid_type_key" ON "public"."Task"("referenceUid", "type");

-- CreateIndex
CREATE UNIQUE INDEX "ManagedOrganization_managedOrganizationId_key" ON "public"."ManagedOrganization"("managedOrganizationId");

-- CreateIndex
CREATE INDEX "ManagedOrganization_managerOrganizationId_idx" ON "public"."ManagedOrganization"("managerOrganizationId");

-- CreateIndex
CREATE UNIQUE INDEX "ManagedOrganization_managerOrganizationId_managedOrganizati_key" ON "public"."ManagedOrganization"("managerOrganizationId", "managedOrganizationId");

-- CreateIndex
CREATE UNIQUE INDEX "PlatformBilling_id_key" ON "public"."PlatformBilling"("id");

-- CreateIndex
CREATE INDEX "Attribute_teamId_idx" ON "public"."Attribute"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "Attribute_teamId_slug_key" ON "public"."Attribute"("teamId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "AttributeToUser_memberId_attributeOptionId_key" ON "public"."AttributeToUser"("memberId", "attributeOptionId");

-- CreateIndex
CREATE UNIQUE INDEX "AssignmentReason_id_key" ON "public"."AssignmentReason"("id");

-- CreateIndex
CREATE INDEX "AssignmentReason_bookingId_idx" ON "public"."AssignmentReason"("bookingId");

-- CreateIndex
CREATE INDEX "DelegationCredential_enabled_idx" ON "public"."DelegationCredential"("enabled");

-- CreateIndex
CREATE UNIQUE INDEX "DelegationCredential_organizationId_domain_key" ON "public"."DelegationCredential"("organizationId", "domain");

-- CreateIndex
CREATE UNIQUE INDEX "DomainWideDelegation_organizationId_domain_key" ON "public"."DomainWideDelegation"("organizationId", "domain");

-- CreateIndex
CREATE UNIQUE INDEX "WorkspacePlatform_slug_key" ON "public"."WorkspacePlatform"("slug");

-- CreateIndex
CREATE INDEX "EventTypeTranslation_eventTypeId_field_targetLocale_idx" ON "public"."EventTypeTranslation"("eventTypeId", "field", "targetLocale");

-- CreateIndex
CREATE UNIQUE INDEX "EventTypeTranslation_eventTypeId_field_targetLocale_key" ON "public"."EventTypeTranslation"("eventTypeId", "field", "targetLocale");

-- CreateIndex
CREATE INDEX "Watchlist_type_value_organizationId_action_idx" ON "public"."Watchlist"("type", "value", "organizationId", "action");

-- CreateIndex
CREATE UNIQUE INDEX "Watchlist_type_value_organizationId_key" ON "public"."Watchlist"("type", "value", "organizationId");

-- CreateIndex
CREATE INDEX "WatchlistAudit_watchlistId_changedAt_idx" ON "public"."WatchlistAudit"("watchlistId", "changedAt");

-- CreateIndex
CREATE UNIQUE INDEX "BookingReport_bookingUid_key" ON "public"."BookingReport"("bookingUid");

-- CreateIndex
CREATE INDEX "BookingReport_bookerEmail_idx" ON "public"."BookingReport"("bookerEmail");

-- CreateIndex
CREATE INDEX "BookingReport_reportedById_idx" ON "public"."BookingReport"("reportedById");

-- CreateIndex
CREATE INDEX "BookingReport_organizationId_idx" ON "public"."BookingReport"("organizationId");

-- CreateIndex
CREATE INDEX "BookingReport_watchlistId_idx" ON "public"."BookingReport"("watchlistId");

-- CreateIndex
CREATE INDEX "BookingReport_createdAt_idx" ON "public"."BookingReport"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationOnboarding_orgOwnerEmail_key" ON "public"."OrganizationOnboarding"("orgOwnerEmail");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationOnboarding_organizationId_key" ON "public"."OrganizationOnboarding"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationOnboarding_stripeCustomerId_key" ON "public"."OrganizationOnboarding"("stripeCustomerId");

-- CreateIndex
CREATE INDEX "OrganizationOnboarding_orgOwnerEmail_idx" ON "public"."OrganizationOnboarding"("orgOwnerEmail");

-- CreateIndex
CREATE INDEX "OrganizationOnboarding_stripeCustomerId_idx" ON "public"."OrganizationOnboarding"("stripeCustomerId");

-- CreateIndex
CREATE INDEX "InternalNotePreset_teamId_idx" ON "public"."InternalNotePreset"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "InternalNotePreset_teamId_name_key" ON "public"."InternalNotePreset"("teamId", "name");

-- CreateIndex
CREATE INDEX "FilterSegment_scope_userId_tableIdentifier_idx" ON "public"."FilterSegment"("scope", "userId", "tableIdentifier");

-- CreateIndex
CREATE INDEX "FilterSegment_scope_teamId_tableIdentifier_idx" ON "public"."FilterSegment"("scope", "teamId", "tableIdentifier");

-- CreateIndex
CREATE INDEX "UserFilterSegmentPreference_userId_idx" ON "public"."UserFilterSegmentPreference"("userId");

-- CreateIndex
CREATE INDEX "UserFilterSegmentPreference_segmentId_idx" ON "public"."UserFilterSegmentPreference"("segmentId");

-- CreateIndex
CREATE UNIQUE INDEX "UserFilterSegmentPreference_userId_tableIdentifier_key" ON "public"."UserFilterSegmentPreference"("userId", "tableIdentifier");

-- CreateIndex
CREATE INDEX "BookingInternalNote_bookingId_idx" ON "public"."BookingInternalNote"("bookingId");

-- CreateIndex
CREATE UNIQUE INDEX "BookingInternalNote_bookingId_notePresetId_key" ON "public"."BookingInternalNote"("bookingId", "notePresetId");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowOptOutContact_type_value_key" ON "public"."WorkflowOptOutContact"("type", "value");

-- CreateIndex
CREATE INDEX "Role_teamId_idx" ON "public"."Role"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_teamId_key" ON "public"."Role"("name", "teamId");

-- CreateIndex
CREATE INDEX "RolePermission_roleId_idx" ON "public"."RolePermission"("roleId");

-- CreateIndex
CREATE INDEX "RolePermission_action_idx" ON "public"."RolePermission"("action");

-- CreateIndex
CREATE UNIQUE INDEX "RolePermission_roleId_resource_action_key" ON "public"."RolePermission"("roleId", "resource", "action");

-- CreateIndex
CREATE UNIQUE INDEX "Agent_providerAgentId_key" ON "public"."Agent"("providerAgentId");

-- CreateIndex
CREATE INDEX "Agent_userId_idx" ON "public"."Agent"("userId");

-- CreateIndex
CREATE INDEX "Agent_teamId_idx" ON "public"."Agent"("teamId");

-- CreateIndex
CREATE INDEX "Agent_inboundEventTypeId_idx" ON "public"."Agent"("inboundEventTypeId");

-- CreateIndex
CREATE INDEX "Agent_outboundEventTypeId_idx" ON "public"."Agent"("outboundEventTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "CalAiPhoneNumber_phoneNumber_key" ON "public"."CalAiPhoneNumber"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "CalAiPhoneNumber_providerPhoneNumberId_key" ON "public"."CalAiPhoneNumber"("providerPhoneNumberId");

-- CreateIndex
CREATE UNIQUE INDEX "CalAiPhoneNumber_stripeSubscriptionId_key" ON "public"."CalAiPhoneNumber"("stripeSubscriptionId");

-- CreateIndex
CREATE INDEX "CalAiPhoneNumber_userId_idx" ON "public"."CalAiPhoneNumber"("userId");

-- CreateIndex
CREATE INDEX "CalAiPhoneNumber_teamId_idx" ON "public"."CalAiPhoneNumber"("teamId");

-- CreateIndex
CREATE INDEX "CalAiPhoneNumber_inboundAgentId_idx" ON "public"."CalAiPhoneNumber"("inboundAgentId");

-- CreateIndex
CREATE INDEX "CalAiPhoneNumber_outboundAgentId_idx" ON "public"."CalAiPhoneNumber"("outboundAgentId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamBilling_teamId_key" ON "public"."TeamBilling"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamBilling_subscriptionId_key" ON "public"."TeamBilling"("subscriptionId");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationBilling_teamId_key" ON "public"."OrganizationBilling"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationBilling_subscriptionId_key" ON "public"."OrganizationBilling"("subscriptionId");

-- CreateIndex
CREATE INDEX "CalendarCacheEvent_start_end_status_idx" ON "public"."CalendarCacheEvent"("start", "end", "status");

-- CreateIndex
CREATE INDEX "CalendarCacheEvent_selectedCalendarId_iCalUID_idx" ON "public"."CalendarCacheEvent"("selectedCalendarId", "iCalUID");

-- CreateIndex
CREATE UNIQUE INDEX "CalendarCacheEvent_selectedCalendarId_externalId_key" ON "public"."CalendarCacheEvent"("selectedCalendarId", "externalId");

-- CreateIndex
CREATE INDEX "_user_eventtype_B_index" ON "public"."_user_eventtype"("B");

-- CreateIndex
CREATE INDEX "_PlatformOAuthClientToUser_B_index" ON "public"."_PlatformOAuthClientToUser"("B");

-- AddForeignKey
ALTER TABLE "public"."Host" ADD CONSTRAINT "Host_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Host" ADD CONSTRAINT "Host_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Host" ADD CONSTRAINT "Host_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "public"."Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Host" ADD CONSTRAINT "Host_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "public"."HostGroup"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Host" ADD CONSTRAINT "Host_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "public"."Membership"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."HostGroup" ADD CONSTRAINT "HostGroup_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalVideoSettings" ADD CONSTRAINT "CalVideoSettings_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "public"."Profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "public"."Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_instantMeetingScheduleId_fkey" FOREIGN KEY ("instantMeetingScheduleId") REFERENCES "public"."Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_secondaryEmailId_fkey" FOREIGN KEY ("secondaryEmailId") REFERENCES "public"."SecondaryEmail"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventType" ADD CONSTRAINT "EventType_restrictionScheduleId_fkey" FOREIGN KEY ("restrictionScheduleId") REFERENCES "public"."Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Credential" ADD CONSTRAINT "Credential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Credential" ADD CONSTRAINT "Credential_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Credential" ADD CONSTRAINT "Credential_appId_fkey" FOREIGN KEY ("appId") REFERENCES "public"."App"("slug") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Credential" ADD CONSTRAINT "Credential_delegationCredentialId_fkey" FOREIGN KEY ("delegationCredentialId") REFERENCES "public"."DelegationCredential"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "public"."Credential"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_delegationCredentialId_fkey" FOREIGN KEY ("delegationCredentialId") REFERENCES "public"."DelegationCredential"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_domainWideDelegationCredentialId_fkey" FOREIGN KEY ("domainWideDelegationCredentialId") REFERENCES "public"."DomainWideDelegation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserPassword" ADD CONSTRAINT "UserPassword_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelSchedule" ADD CONSTRAINT "TravelSchedule_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_movedToProfileId_fkey" FOREIGN KEY ("movedToProfileId") REFERENCES "public"."Profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."NotificationsSubscriptions" ADD CONSTRAINT "NotificationsSubscriptions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Profile" ADD CONSTRAINT "Profile_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Team" ADD CONSTRAINT "Team_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Team" ADD CONSTRAINT "Team_createdByOAuthClientId_fkey" FOREIGN KEY ("createdByOAuthClientId") REFERENCES "public"."PlatformOAuthClient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CreditBalance" ADD CONSTRAINT "CreditBalance_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CreditBalance" ADD CONSTRAINT "CreditBalance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CreditPurchaseLog" ADD CONSTRAINT "CreditPurchaseLog_creditBalanceId_fkey" FOREIGN KEY ("creditBalanceId") REFERENCES "public"."CreditBalance"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CreditExpenseLog" ADD CONSTRAINT "CreditExpenseLog_creditBalanceId_fkey" FOREIGN KEY ("creditBalanceId") REFERENCES "public"."CreditBalance"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CreditExpenseLog" ADD CONSTRAINT "CreditExpenseLog_bookingUid_fkey" FOREIGN KEY ("bookingUid") REFERENCES "public"."Booking"("uid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrganizationSettings" ADD CONSTRAINT "OrganizationSettings_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Membership" ADD CONSTRAINT "Membership_customRoleId_fkey" FOREIGN KEY ("customRoleId") REFERENCES "public"."Role"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Membership" ADD CONSTRAINT "Membership_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Membership" ADD CONSTRAINT "Membership_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."VerificationToken" ADD CONSTRAINT "VerificationToken_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."VerificationToken" ADD CONSTRAINT "VerificationToken_secondaryEmailId_fkey" FOREIGN KEY ("secondaryEmailId") REFERENCES "public"."SecondaryEmail"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InstantMeetingToken" ADD CONSTRAINT "InstantMeetingToken_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InstantMeetingToken" ADD CONSTRAINT "InstantMeetingToken_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReference" ADD CONSTRAINT "BookingReference_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReference" ADD CONSTRAINT "BookingReference_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "public"."Credential"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReference" ADD CONSTRAINT "BookingReference_delegationCredentialId_fkey" FOREIGN KEY ("delegationCredentialId") REFERENCES "public"."DelegationCredential"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReference" ADD CONSTRAINT "BookingReference_domainWideDelegationCredentialId_fkey" FOREIGN KEY ("domainWideDelegationCredentialId") REFERENCES "public"."DomainWideDelegation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Attendee" ADD CONSTRAINT "Attendee_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Booking" ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Booking" ADD CONSTRAINT "Booking_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Booking" ADD CONSTRAINT "Booking_destinationCalendarId_fkey" FOREIGN KEY ("destinationCalendarId") REFERENCES "public"."DestinationCalendar"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Booking" ADD CONSTRAINT "Booking_reassignById_fkey" FOREIGN KEY ("reassignById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Tracking" ADD CONSTRAINT "Tracking_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Schedule" ADD CONSTRAINT "Schedule_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Availability" ADD CONSTRAINT "Availability_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Availability" ADD CONSTRAINT "Availability_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Availability" ADD CONSTRAINT "Availability_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "public"."Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SelectedCalendar" ADD CONSTRAINT "SelectedCalendar_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SelectedCalendar" ADD CONSTRAINT "SelectedCalendar_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "public"."Credential"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SelectedCalendar" ADD CONSTRAINT "SelectedCalendar_delegationCredentialId_fkey" FOREIGN KEY ("delegationCredentialId") REFERENCES "public"."DelegationCredential"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SelectedCalendar" ADD CONSTRAINT "SelectedCalendar_domainWideDelegationCredentialId_fkey" FOREIGN KEY ("domainWideDelegationCredentialId") REFERENCES "public"."DomainWideDelegation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SelectedCalendar" ADD CONSTRAINT "SelectedCalendar_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventTypeCustomInput" ADD CONSTRAINT "EventTypeCustomInput_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Payment" ADD CONSTRAINT "Payment_appId_fkey" FOREIGN KEY ("appId") REFERENCES "public"."App"("slug") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Payment" ADD CONSTRAINT "Payment_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Webhook" ADD CONSTRAINT "Webhook_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Webhook" ADD CONSTRAINT "Webhook_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Webhook" ADD CONSTRAINT "Webhook_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Webhook" ADD CONSTRAINT "Webhook_platformOAuthClientId_fkey" FOREIGN KEY ("platformOAuthClientId") REFERENCES "public"."PlatformOAuthClient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Webhook" ADD CONSTRAINT "Webhook_appId_fkey" FOREIGN KEY ("appId") REFERENCES "public"."App"("slug") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Impersonations" ADD CONSTRAINT "Impersonations_impersonatedUserId_fkey" FOREIGN KEY ("impersonatedUserId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Impersonations" ADD CONSTRAINT "Impersonations_impersonatedById_fkey" FOREIGN KEY ("impersonatedById") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ApiKey" ADD CONSTRAINT "ApiKey_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ApiKey" ADD CONSTRAINT "ApiKey_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ApiKey" ADD CONSTRAINT "ApiKey_appId_fkey" FOREIGN KEY ("appId") REFERENCES "public"."App"("slug") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RateLimit" ADD CONSTRAINT "RateLimit_apiKeyId_fkey" FOREIGN KEY ("apiKeyId") REFERENCES "public"."ApiKey"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."HashedLink" ADD CONSTRAINT "HashedLink_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_Form" ADD CONSTRAINT "App_RoutingForms_Form_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_Form" ADD CONSTRAINT "App_RoutingForms_Form_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_Form" ADD CONSTRAINT "App_RoutingForms_Form_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_FormResponse" ADD CONSTRAINT "App_RoutingForms_FormResponse_formId_fkey" FOREIGN KEY ("formId") REFERENCES "public"."App_RoutingForms_Form"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_FormResponse" ADD CONSTRAINT "App_RoutingForms_FormResponse_routedToBookingUid_fkey" FOREIGN KEY ("routedToBookingUid") REFERENCES "public"."Booking"("uid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_QueuedFormResponse" ADD CONSTRAINT "App_RoutingForms_QueuedFormResponse_formId_fkey" FOREIGN KEY ("formId") REFERENCES "public"."App_RoutingForms_Form"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_QueuedFormResponse" ADD CONSTRAINT "App_RoutingForms_QueuedFormResponse_actualResponseId_fkey" FOREIGN KEY ("actualResponseId") REFERENCES "public"."App_RoutingForms_FormResponse"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RoutingFormResponseField" ADD CONSTRAINT "RoutingFormResponseField_response_fkey" FOREIGN KEY ("responseId") REFERENCES "public"."App_RoutingForms_FormResponse"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RoutingFormResponseField" ADD CONSTRAINT "RoutingFormResponseField_responseId_fkey" FOREIGN KEY ("responseId") REFERENCES "public"."RoutingFormResponseDenormalized"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RoutingFormResponseDenormalized" ADD CONSTRAINT "RoutingFormResponseDenormalized_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RoutingFormResponseDenormalized" ADD CONSTRAINT "RoutingFormResponseDenormalized_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."App_RoutingForms_FormResponse"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Feedback" ADD CONSTRAINT "Feedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowStep" ADD CONSTRAINT "WorkflowStep_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "public"."Workflow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowStep" ADD CONSTRAINT "WorkflowStep_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "public"."Agent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowStep" ADD CONSTRAINT "WorkflowStep_inboundAgentId_fkey" FOREIGN KEY ("inboundAgentId") REFERENCES "public"."Agent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Workflow" ADD CONSTRAINT "Workflow_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Workflow" ADD CONSTRAINT "Workflow_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AIPhoneCallConfiguration" ADD CONSTRAINT "AIPhoneCallConfiguration_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowsOnEventTypes" ADD CONSTRAINT "WorkflowsOnEventTypes_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "public"."Workflow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowsOnEventTypes" ADD CONSTRAINT "WorkflowsOnEventTypes_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowsOnRoutingForms" ADD CONSTRAINT "WorkflowsOnRoutingForms_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "public"."Workflow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowsOnRoutingForms" ADD CONSTRAINT "WorkflowsOnRoutingForms_routingFormId_fkey" FOREIGN KEY ("routingFormId") REFERENCES "public"."App_RoutingForms_Form"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowsOnTeams" ADD CONSTRAINT "WorkflowsOnTeams_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "public"."Workflow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowsOnTeams" ADD CONSTRAINT "WorkflowsOnTeams_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowReminder" ADD CONSTRAINT "WorkflowReminder_bookingUid_fkey" FOREIGN KEY ("bookingUid") REFERENCES "public"."Booking"("uid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WorkflowReminder" ADD CONSTRAINT "WorkflowReminder_workflowStepId_fkey" FOREIGN KEY ("workflowStepId") REFERENCES "public"."WorkflowStep"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WebhookScheduledTriggers" ADD CONSTRAINT "WebhookScheduledTriggers_webhookId_fkey" FOREIGN KEY ("webhookId") REFERENCES "public"."Webhook"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WebhookScheduledTriggers" ADD CONSTRAINT "WebhookScheduledTriggers_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingSeat" ADD CONSTRAINT "BookingSeat_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingSeat" ADD CONSTRAINT "BookingSeat_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES "public"."Attendee"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."VerifiedNumber" ADD CONSTRAINT "VerifiedNumber_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."VerifiedNumber" ADD CONSTRAINT "VerifiedNumber_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."VerifiedEmail" ADD CONSTRAINT "VerifiedEmail_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."VerifiedEmail" ADD CONSTRAINT "VerifiedEmail_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserFeatures" ADD CONSTRAINT "UserFeatures_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserFeatures" ADD CONSTRAINT "UserFeatures_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "public"."Feature"("slug") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamFeatures" ADD CONSTRAINT "TeamFeatures_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamFeatures" ADD CONSTRAINT "TeamFeatures_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "public"."Feature"("slug") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AccessCode" ADD CONSTRAINT "AccessCode_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "public"."OAuthClient"("clientId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AccessCode" ADD CONSTRAINT "AccessCode_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AccessCode" ADD CONSTRAINT "AccessCode_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalendarCache" ADD CONSTRAINT "CalendarCache_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "public"."Credential"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OutOfOfficeEntry" ADD CONSTRAINT "OutOfOfficeEntry_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OutOfOfficeEntry" ADD CONSTRAINT "OutOfOfficeEntry_toUserId_fkey" FOREIGN KEY ("toUserId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OutOfOfficeEntry" ADD CONSTRAINT "OutOfOfficeEntry_reasonId_fkey" FOREIGN KEY ("reasonId") REFERENCES "public"."OutOfOfficeReason"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OutOfOfficeReason" ADD CONSTRAINT "OutOfOfficeReason_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlatformOAuthClient" ADD CONSTRAINT "PlatformOAuthClient_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlatformAuthorizationToken" ADD CONSTRAINT "PlatformAuthorizationToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlatformAuthorizationToken" ADD CONSTRAINT "PlatformAuthorizationToken_platformOAuthClientId_fkey" FOREIGN KEY ("platformOAuthClientId") REFERENCES "public"."PlatformOAuthClient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AccessToken" ADD CONSTRAINT "AccessToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AccessToken" ADD CONSTRAINT "AccessToken_platformOAuthClientId_fkey" FOREIGN KEY ("platformOAuthClientId") REFERENCES "public"."PlatformOAuthClient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RefreshToken" ADD CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RefreshToken" ADD CONSTRAINT "RefreshToken_platformOAuthClientId_fkey" FOREIGN KEY ("platformOAuthClientId") REFERENCES "public"."PlatformOAuthClient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DSyncData" ADD CONSTRAINT "DSyncData_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."OrganizationSettings"("organizationId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DSyncTeamGroupMapping" ADD CONSTRAINT "DSyncTeamGroupMapping_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DSyncTeamGroupMapping" ADD CONSTRAINT "DSyncTeamGroupMapping_directoryId_fkey" FOREIGN KEY ("directoryId") REFERENCES "public"."DSyncData"("directoryId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SecondaryEmail" ADD CONSTRAINT "SecondaryEmail_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ManagedOrganization" ADD CONSTRAINT "ManagedOrganization_managedOrganizationId_fkey" FOREIGN KEY ("managedOrganizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ManagedOrganization" ADD CONSTRAINT "ManagedOrganization_managerOrganizationId_fkey" FOREIGN KEY ("managerOrganizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlatformBilling" ADD CONSTRAINT "PlatformBilling_managerBillingId_fkey" FOREIGN KEY ("managerBillingId") REFERENCES "public"."PlatformBilling"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlatformBilling" ADD CONSTRAINT "PlatformBilling_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeOption" ADD CONSTRAINT "AttributeOption_attributeId_fkey" FOREIGN KEY ("attributeId") REFERENCES "public"."Attribute"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Attribute" ADD CONSTRAINT "Attribute_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeToUser" ADD CONSTRAINT "AttributeToUser_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "public"."Membership"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeToUser" ADD CONSTRAINT "AttributeToUser_attributeOptionId_fkey" FOREIGN KEY ("attributeOptionId") REFERENCES "public"."AttributeOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeToUser" ADD CONSTRAINT "AttributeToUser_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeToUser" ADD CONSTRAINT "AttributeToUser_createdByDSyncId_fkey" FOREIGN KEY ("createdByDSyncId") REFERENCES "public"."DSyncData"("directoryId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeToUser" ADD CONSTRAINT "AttributeToUser_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AttributeToUser" ADD CONSTRAINT "AttributeToUser_updatedByDSyncId_fkey" FOREIGN KEY ("updatedByDSyncId") REFERENCES "public"."DSyncData"("directoryId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AssignmentReason" ADD CONSTRAINT "AssignmentReason_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DelegationCredential" ADD CONSTRAINT "DelegationCredential_workspacePlatformId_fkey" FOREIGN KEY ("workspacePlatformId") REFERENCES "public"."WorkspacePlatform"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DelegationCredential" ADD CONSTRAINT "DelegationCredential_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DomainWideDelegation" ADD CONSTRAINT "DomainWideDelegation_workspacePlatformId_fkey" FOREIGN KEY ("workspacePlatformId") REFERENCES "public"."WorkspacePlatform"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DomainWideDelegation" ADD CONSTRAINT "DomainWideDelegation_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventTypeTranslation" ADD CONSTRAINT "EventTypeTranslation_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventTypeTranslation" ADD CONSTRAINT "EventTypeTranslation_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."EventTypeTranslation" ADD CONSTRAINT "EventTypeTranslation_updatedBy_fkey" FOREIGN KEY ("updatedBy") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."WatchlistAudit" ADD CONSTRAINT "WatchlistAudit_watchlistId_fkey" FOREIGN KEY ("watchlistId") REFERENCES "public"."Watchlist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReport" ADD CONSTRAINT "BookingReport_bookingUid_fkey" FOREIGN KEY ("bookingUid") REFERENCES "public"."Booking"("uid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReport" ADD CONSTRAINT "BookingReport_reportedById_fkey" FOREIGN KEY ("reportedById") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReport" ADD CONSTRAINT "BookingReport_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingReport" ADD CONSTRAINT "BookingReport_watchlistId_fkey" FOREIGN KEY ("watchlistId") REFERENCES "public"."Watchlist"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrganizationOnboarding" ADD CONSTRAINT "OrganizationOnboarding_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrganizationOnboarding" ADD CONSTRAINT "OrganizationOnboarding_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."App_RoutingForms_IncompleteBookingActions" ADD CONSTRAINT "App_RoutingForms_IncompleteBookingActions_formId_fkey" FOREIGN KEY ("formId") REFERENCES "public"."App_RoutingForms_Form"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InternalNotePreset" ADD CONSTRAINT "InternalNotePreset_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."FilterSegment" ADD CONSTRAINT "FilterSegment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."FilterSegment" ADD CONSTRAINT "FilterSegment_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserFilterSegmentPreference" ADD CONSTRAINT "UserFilterSegmentPreference_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserFilterSegmentPreference" ADD CONSTRAINT "UserFilterSegmentPreference_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES "public"."FilterSegment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingInternalNote" ADD CONSTRAINT "BookingInternalNote_notePresetId_fkey" FOREIGN KEY ("notePresetId") REFERENCES "public"."InternalNotePreset"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingInternalNote" ADD CONSTRAINT "BookingInternalNote_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "public"."Booking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BookingInternalNote" ADD CONSTRAINT "BookingInternalNote_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Role" ADD CONSTRAINT "Role_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RolePermission" ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Agent" ADD CONSTRAINT "Agent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Agent" ADD CONSTRAINT "Agent_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalAiPhoneNumber" ADD CONSTRAINT "CalAiPhoneNumber_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalAiPhoneNumber" ADD CONSTRAINT "CalAiPhoneNumber_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalAiPhoneNumber" ADD CONSTRAINT "CalAiPhoneNumber_inboundAgentId_fkey" FOREIGN KEY ("inboundAgentId") REFERENCES "public"."Agent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalAiPhoneNumber" ADD CONSTRAINT "CalAiPhoneNumber_outboundAgentId_fkey" FOREIGN KEY ("outboundAgentId") REFERENCES "public"."Agent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamBilling" ADD CONSTRAINT "TeamBilling_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrganizationBilling" ADD CONSTRAINT "OrganizationBilling_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CalendarCacheEvent" ADD CONSTRAINT "CalendarCacheEvent_selectedCalendarId_fkey" FOREIGN KEY ("selectedCalendarId") REFERENCES "public"."SelectedCalendar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_user_eventtype" ADD CONSTRAINT "_user_eventtype_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_user_eventtype" ADD CONSTRAINT "_user_eventtype_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_PlatformOAuthClientToUser" ADD CONSTRAINT "_PlatformOAuthClientToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."PlatformOAuthClient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_PlatformOAuthClientToUser" ADD CONSTRAINT "_PlatformOAuthClientToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

