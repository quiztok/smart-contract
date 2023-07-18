pragma solidity ^0.5.1;




library SafeMath {
 
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}




contract Context {
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; 
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
}


contract QuiztokUserQuestion is Ownable{

    struct userQuestion{
        string subject; // 문제 제목
        string subjectUrl; // 문제 이미지
        string option1; // 보기 
        string option2; // 보기 
        string option3; // 보기 
        string option4; // 보기 
        string answer; // 문제 답 번호 
    }

    struct userQuestionRelevant{ // 문제 유형 정보 
      string contentType;
      string questionType;
      string answerType;

    }

    struct userQuestionRenew {
      string status; // 문제 등록 상태 (신규, 수정, 삭제, 신고)
      string questionId; // 문제 번호
    }

    struct matchingUserQuestion{
      uint256 num;
      string wallet;
    }



    mapping(uint256 => matchingUserQuestion) matchingUserQuestionInfo;
    mapping(string => matchingUserQuestion[]) matchingUserQuestions;


    
    mapping(uint256 => userQuestionRenew) userQuestionRenewInfo;
    mapping(string => userQuestionRenew[]) userQuestionRenews;
    userQuestionRenew[] private userQuestionRenewData;
    


    mapping(uint256 => userQuestion) userQuestionInfo;
    mapping(string => userQuestion[]) userQuestions;
    userQuestion[] private userQuestionData;
    


    mapping(uint256 => userQuestionRelevant) userQuestionRelevantInfo;
    mapping(string => userQuestionRelevant[]) userQuestionRelevants;


    function userQuestionStatusHistoryRecord(uint256 _num , string memory _wallet , string memory _questionId, string memory _status) public onlyOwner {
      userQuestionRenew storage newUserQuestionRenew = userQuestionRenewInfo[_num];
      newUserQuestionRenew.status = _status;
      newUserQuestionRenew.questionId = _questionId;
      userQuestionRenews[_wallet].push(newUserQuestionRenew); 


      userQuestionRenewData.push(newUserQuestionRenew);

      matchingUserQuestion storage newMatchingUserQuestion = matchingUserQuestionInfo[0]; 
      newMatchingUserQuestion.num = _num;
      newMatchingUserQuestion.wallet = _wallet;
      matchingUserQuestions[_questionId].push(newMatchingUserQuestion);
    }

    function getQuestionIdByInfo(string memory _questionId) public view returns(string memory, uint256){
        matchingUserQuestion storage r = matchingUserQuestions[_questionId][0];
        return(r.wallet , r.num); 
    }

    function getUserQuestionHistoryRecordTotalCount()public view returns(uint256){
        return userQuestionRenewData.length;
    }

    function getUserQuestionHistoryRecordCount(string memory _wallet) public view returns(uint256){
        return userQuestionRenews[_wallet].length;
    }


    function getUserQuestionHistoryRecord(uint256 _num , string memory _wallet) public view returns(string memory, string memory){
      userQuestionRenew storage r  = userQuestionRenews[_wallet][_num-1];
      return(r.status , r.questionId); 
    }


    function registerUserQuestion(uint256 _num , string memory _wallet , string memory _subject ,  string memory _subjectUrl , 
                                  string memory _option1 , string memory _option2 , string memory _option3 , string memory _option4 ,
                                  string memory _answer , string memory _contentType , string memory _questionType , string memory _answerType 
                                  ) public onlyOwner { // 퀴즈팩 정보 등록 
                                   
        userQuestion storage newUserQuestion = userQuestionInfo[_num];
        newUserQuestion.subject = _subject; 
        newUserQuestion.subjectUrl = _subjectUrl;
        
        newUserQuestion.option1 = _option1;
        newUserQuestion.option2 = _option2;
        newUserQuestion.option3 = _option3;
        newUserQuestion.option4 = _option4;
        
        
        newUserQuestion.answer = _answer; 
        userQuestionData.push(newUserQuestion);
        userQuestions[_wallet].push(newUserQuestion);


        userQuestionRelevant storage newUserQuestionRelevant = userQuestionRelevantInfo[_num];   
        
        newUserQuestionRelevant.contentType = _contentType;
        newUserQuestionRelevant.questionType = _questionType;
        newUserQuestionRelevant.answerType = _answerType;

        userQuestionRelevants[_wallet].push(newUserQuestionRelevant);

    }



    function getUserQuestionCount(string memory _wallet) public view returns(uint256){
      return userQuestions[_wallet].length;
    }

    function getUserQuestionTotalCount() public view returns(uint256){
      return userQuestionData.length;
    }

    function getUserQuestion(string memory _wallet , uint256 _num) public view returns(string memory, string memory, string memory, string memory, string memory, string memory,  string memory ){
        userQuestion storage r = userQuestions[_wallet][_num-1];
        return(r.subject, r.subjectUrl ,r.option1, r.option2 , r.option3, r.option4 , r.answer );
    }

    function getUserQuestionRelevant(string memory _wallet , uint256 _num) public view returns(string memory, string memory, string memory){
        userQuestionRelevant storage r = userQuestionRelevants[_wallet][_num-1];
        return(r.contentType , r.questionType , r.answerType);
    }

}
