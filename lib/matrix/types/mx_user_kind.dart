enum MxUserKind { guest, user }

String mxUserKindString(MxUserKind kind) {
  switch (kind) {
    case MxUserKind.guest:
      return "guest";
    case MxUserKind.user:
      return "user";
    default:
      throw new Exception("Unknown MxUserKind :$kind");
  }
}
