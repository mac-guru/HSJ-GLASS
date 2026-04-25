-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT,
    "role" TEXT NOT NULL DEFAULT 'staff',
    "department" TEXT,
    "baseSalary" REAL NOT NULL DEFAULT 0,
    "joiningDate" DATETIME,
    "status" TEXT NOT NULL DEFAULT 'active',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Attendance" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "clockInTime" DATETIME,
    "clockOutTime" DATETIME,
    "workingHours" REAL,
    "status" TEXT,
    "lateByMinutes" INTEGER,
    "earlyLeaveMinutes" INTEGER,
    "leaveType" TEXT,
    "remarks" TEXT,
    "markedBy" TEXT,
    "clockInIp" TEXT,
    "clockOutIp" TEXT,
    "clockInDeviceId" TEXT,
    "clockInPhoto" TEXT,
    "clockOutPhoto" TEXT,
    "otpVerified" BOOLEAN NOT NULL DEFAULT false,
    "verificationMethod" TEXT,
    "autoClockout" BOOLEAN NOT NULL DEFAULT false,
    "clockoutMethod" TEXT,
    "reportSubmitted" BOOLEAN NOT NULL DEFAULT false,
    "flaggedForReview" BOOLEAN NOT NULL DEFAULT false,
    "adminOverrideStatus" TEXT,
    "adminOverrideReason" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Attendance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "AttendanceBreak" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "attendanceId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "breakStartTime" DATETIME NOT NULL,
    "breakEndTime" DATETIME,
    "breakType" TEXT NOT NULL,
    "reason" TEXT,
    "durationMinutes" INTEGER,
    "approvedByAdmin" TEXT NOT NULL DEFAULT 'pending',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "AttendanceBreak_attendanceId_fkey" FOREIGN KEY ("attendanceId") REFERENCES "Attendance" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AttendanceBreak_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "OfficeSetting" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "officeStartTime" TEXT NOT NULL,
    "officeEndTime" TEXT NOT NULL,
    "lateGraceMinutes" INTEGER NOT NULL DEFAULT 15,
    "halfDayThresholdHours" REAL NOT NULL DEFAULT 4.0,
    "fullDayThresholdHours" REAL NOT NULL DEFAULT 7.0,
    "lunchBreakAllowedMinutes" INTEGER NOT NULL DEFAULT 60,
    "maxPersonalBreakPerDay" INTEGER NOT NULL DEFAULT 30,
    "officialBreakNeedsApproval" BOOLEAN NOT NULL DEFAULT false,
    "workingDays" TEXT NOT NULL,
    "allowedIpAddresses" TEXT NOT NULL,
    "requirePhotoAtClockin" BOOLEAN NOT NULL DEFAULT false,
    "requireOtpAtClockin" BOOLEAN NOT NULL DEFAULT false,
    "requireDeviceBinding" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "TrustedDevice" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "deviceId" TEXT NOT NULL,
    "deviceName" TEXT,
    "registeredOn" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsed" DATETIME,
    "active" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "TrustedDevice_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "LeaveBalance" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "casualLeaveTotal" REAL NOT NULL DEFAULT 0,
    "casualLeaveUsed" REAL NOT NULL DEFAULT 0,
    "sickLeaveTotal" REAL NOT NULL DEFAULT 0,
    "sickLeaveUsed" REAL NOT NULL DEFAULT 0,
    "paidLeaveTotal" REAL NOT NULL DEFAULT 0,
    "paidLeaveUsed" REAL NOT NULL DEFAULT 0,
    CONSTRAINT "LeaveBalance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "LeaveRequest" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "fromDate" DATETIME NOT NULL,
    "toDate" DATETIME NOT NULL,
    "leaveType" TEXT NOT NULL,
    "reason" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "approvedBy" TEXT,
    "approvedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "LeaveRequest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Task" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "assignedToId" TEXT NOT NULL,
    "assignedById" TEXT NOT NULL,
    "priority" TEXT NOT NULL DEFAULT 'medium',
    "deadline" DATETIME,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "completedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Task_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Task_assignedById_fkey" FOREIGN KEY ("assignedById") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DailyReport" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "workDone" TEXT NOT NULL,
    "followUps" TEXT,
    "challenges" TEXT,
    "adminComment" TEXT,
    "submittedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "DailyReport_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Deal" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "clientName" TEXT NOT NULL,
    "clientContact" TEXT,
    "packageName" TEXT,
    "dealAmount" REAL NOT NULL,
    "paymentStatus" TEXT NOT NULL DEFAULT 'pending',
    "dealDate" DATETIME NOT NULL,
    "incentiveAmount" REAL,
    "status" TEXT NOT NULL DEFAULT 'pending_approval',
    "approvedById" TEXT,
    "approvedAt" DATETIME,
    "notes" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Deal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Deal_approvedById_fkey" FOREIGN KEY ("approvedById") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "IncentiveRule" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "ruleName" TEXT NOT NULL,
    "minAmount" REAL NOT NULL,
    "maxAmount" REAL,
    "percentage" REAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "Deduction" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "month" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "notes" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Deduction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Payroll" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "month" TEXT NOT NULL,
    "baseSalary" REAL NOT NULL,
    "totalIncentive" REAL NOT NULL DEFAULT 0,
    "totalDeduction" REAL NOT NULL DEFAULT 0,
    "netSalary" REAL NOT NULL,
    "generatedOn" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL DEFAULT 'draft',
    CONSTRAINT "Payroll_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
