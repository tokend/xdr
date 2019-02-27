

%#include "xdr/Stellar-types.h"

namespace stellar
{

//: AssetCreationRequest is used to create asset with provided parameters
struct AssetCreationRequest {
    //: Code of the asset to create
    AssetCode code;
    //: AccountID of the account that will perform preissuance
    AccountID preissuedAssetSigner;
    //: Maximal amount to be issued
    uint64 maxIssuanceAmount;
    //: Amount to preissue on asset creation
    uint64 initialPreissuedAmount;
    //: Bitmask of policies to create asset with
    uint32 policies;
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails; // details set by requester
    //: Asset type
    uint64 type;
    //: Used to keep track of rejected requests update. On each rejected AssetCreationRequest update, sequenceNumber increases
    uint32 sequenceNumber;
    //: Number of significant decimal places
    uint32 trailingDigitsCount;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
//: AssetUpdateRequest is used to update asset with provided parameters
struct AssetUpdateRequest {
    //: Code of asset to update
    AssetCode code;
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails; // details set by requester
    //: New policies to set, will override existing ones
    uint32 policies;
    //: Used to keep track of rejected requests update. On each rejected AssetUpdateRequest update, sequenceNumber increases
    uint32 sequenceNumber;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
//: AssetChangePreissuedSigner is used to update preissued asset signer
struct AssetChangePreissuedSigner
{
    //: code of the asset to update
    AssetCode code;
    //: AccountID of account to set as preissued signer
    AccountID accountID;
    //: ??
    DecoratedSignature signature;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
