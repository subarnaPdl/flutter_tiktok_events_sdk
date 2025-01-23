enum BaseEventName {
  achieveLevel("AchieveLevel"),
  addPaymentInfo("AddPaymentInfo"),
  completeTutorial("CompleteTutorial"),
  createGroup("CreateGroup"),
  createRole("CreateRole"),
  generateLead("GenerateLead"),
  inAppAdClick("InAppADClick"),
  inAppAdImpr("InAppAdImpr"),
  installApp("InstallApp"),
  joinGroup("JoinGroup"),
  launchApp("LaunchAPP"),
  loanApplication("LoanApplication"),
  loanApproval("LoanApproval"),
  loanDisbursal("LoanDisbursal"),
  login("Login"),
  rate("Rate"),
  registration("Registration"),
  search("Search"),
  spendCredits("SpendCredits"),
  startTrial("StartTrial"),
  subscribe("Subscribe"),
  unlockAchievement("UnlockAchievement");

  final String value;

  const BaseEventName(this.value);

  @override
  String toString() => value;
}
