

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{


/* CreateIssuanceRequestOp

    Creates new issuance request

    Threshold: high

    Result: CreateIssuanceRequestResult
*/
//: CreateIssuanceRequestOp creates new issuance request
struct CreateIssuanceRequestOp
{
  //: Issuance request to create
	IssuanceRequest request;
  //: Reference of the request
	string64 reference;
  //: Tasks to set on 
  uint32* allTasks;
	//: Reserved for future use
  union switch (LedgerVersion v)
  {
  case EMPTY_VERSION:
    void;
  }
  ext;
};

/******* CreateIssuanceRequest Result ********/
//: Result codes of the CreateIssuanceRequestOp
enum CreateIssuanceRequestResultCode
{
  // codes considered as "success" for the operation
  //: Operation application was successful
  SUCCESS = 0,

  // codes considered as "failure" for the operation
  //: Asset to issue not found
  ASSET_NOT_FOUND = -1,
  //: Trying to create issuance request with negative/zero amount
	INVALID_AMOUNT = -2,
  //: Request with the same reference already exists
	REFERENCE_DUPLICATION = -3,
  //: Target balance not found or asset of the target balance and asset in the request mismatched
	NO_COUNTERPARTY = -4,
  //: Source account not allowed to perform issuance
	NOT_AUTHORIZED = -5,
  //: Issued amount plus amount to issue will exceed max issuance amount
	EXCEEDS_MAX_ISSUANCE_AMOUNT = -6,
  //: Amount to issue plus amount on balance would exceed UINT64_MAX 
	RECEIVER_FULL_LINE = -7,
  //: Either creator details are not valid JSON or it's size exceed 4096 bytes
	INVALID_CREATOR_DETAILS = -8,
  //: Fee is greater than amount to issue
	FEE_EXCEEDS_AMOUNT = -9,
  //: Deprecated
  REQUIRES_KYC = -10,
  //: Deprecated
  REQUIRES_VERIFICATION = -11, //asset requires receiver to be verified
  //: Issuance tasks were not provided on request creation and corresponding KeyValue is not set
  ISSUANCE_TASKS_NOT_FOUND = -12,
  //: Not allowed to set tasks < 1024
  SYSTEM_TASKS_NOT_ALLOWED = -13,
  //: Amount precision and asset precision are mismatched
  INVALID_AMOUNT_PRECISION = -14
};

//:Result of successful application of CreateIssuanceRequest operation
struct CreateIssuanceRequestSuccess {
  //: ID of newly created issuance request
	uint64 requestID;
  //: Account address of the receiver
	AccountID receiver;
  //: Boolean indication whether the Issuance request was approved and applied on creation
	bool fulfilled;
  //: Paid fee
	Fee fee;
  //: Reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};
//: Create issuance request result with result code
union CreateIssuanceRequestResult switch (CreateIssuanceRequestResultCode code)
{
case SUCCESS:
  CreateIssuanceRequestSuccess success;
default:
  void;
};

}
