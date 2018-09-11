function Exception()
{
  this.name = "";
  this.message = "";
  
  this.setName = function(str)
  {
    this.name = str;
  }
  
  this.setMessage = function(str)
  {
    this.message = str;
  }
}

function BizException()
{
  this.bizId = "";
  this.errorCode = "";
  this.errorMsg = "";
  this.errorGrade = "";
  this.innerException = null;
  
  this.setBizId = function(str)
  {
    this.bizId = str;
  }
  
  this.setErrorCode = function(str)
  {
    this.errorCode = str;
  }
  
  this.setErrorMsg = function(str)
  {
    this.errorMsg = str;
  }
  
  this.setErrorGrade = function(errType)
  {
    this.errorGrade = errType;
  }
  
  this.setInnerException = function(ex)
  {
    this.innerException = ex;
  }
}

var ErrorGrade =
{
  Warning : "Warning",
  Error : "Error",
  Fatal : "Fatal"
}