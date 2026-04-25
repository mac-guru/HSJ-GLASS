import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Staff Management System | Himalayan Social Journey",
  description: "Internal staff management system, daily workflow tracker, and payroll.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
