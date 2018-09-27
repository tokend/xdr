%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageITSaleCreationRequestOp

    Creates, updates or removes investment token sale creation request

    Threshold: high

    Result: ManageITSaleCreationRequestResult
*/

enum ManageITSaleCreationRequestAction
{
    CREATE = 0,
    UPDATE = 1,
    CANCEL = 2
};

struct UpdateCreationRequestDetails
{
    uint64 requestID;
    InvestmentTokenSaleCreationRequest request;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManageITSaleCreationRequestOp
{
    union switch (ManageITSaleCreationRequestAction action)
    {
    case CREATE:
        InvestmentTokenSaleCreationRequest creationRequest;
    case UPDATE:
        UpdateCreationRequestDetails updateDetails;
    case CANCEL:
        uint64 requestToCancelID;
    } data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ManageITSaleCreationRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_BASE_ASSET = -1,
    INVALID_AMOUNT_TO_BE_SOLD = -2,
    INVALID_DETAILS = -3,
    QUOTE_ASSETS_IS_EMPTY = -4,
    INVALID_ASSET_PAIR = -5,
    INVALID_PRICE = -6,
    SETTLEMENT_START_DATE_IS_BEFORE_TRADING_START_DATE = -7,
    SETTLEMENT_START_END_INVALID = -8,
    INVALID_DEFAULT_REDEMPTION_ASSET = -9,
    SALE_CREATION_REQUEST_NOT_FOUND = -10,
    INVALID_TRADING_START_DATE = -11,
    INVALID_SETTLEMENT_START_DATE = -12,
    INVALID_SETTLEMENT_END_DATE = -13,
    REQUEST_OR_SALE_ALREADY_EXISTS = -14,
    QUOTE_ASSET_NOT_FOUND = -15,
    BASE_ASSET_OR_REQUEST_NOT_FOUND = -16,
    INVESTMENT_TOKEN_SALE_CREATION_TASKS_NOT_FOUND = -17
};

struct ManageITSaleCreationRequestSuccess
{
    uint64 requestID;
    bool fulfilled;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

union ManageITSaleCreationRequestResult switch (ManageITSaleCreationRequestResultCode code)
{
    case SUCCESS:
        ManageITSaleCreationRequestSuccess success;
    default:
        void;
};

}